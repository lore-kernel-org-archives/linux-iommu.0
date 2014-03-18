From: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 17/27] iommu/exynos: remove calls to Runtime PM API
	functions
Date: Tue, 18 Mar 2014 16:09:50 +0100
Message-ID: <532861BE.7020601@samsung.com>
References: <20140314140843.ba055f28dd7ed59c46088029@samsung.com>
	<5322FD14.5090602@samsung.com>
	<20140318185605.0380c8dfe6559c06183092e5@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20140318185605.0380c8dfe6559c06183092e5-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Cho KyongHo <pullip.cho-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Linux DeviceTree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Samsung SOC <linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Prathyush <prathyush.k-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Grant Grundler <grundler-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Linux Kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sachin Kamat <sachin.kamat-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Linux IOMMU <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Kukjin Kim <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Sylwester Nawrocki <s.nawrocki-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Antonios Motakis <a.motakis-lrHrjnjw1UfHK3s98zE1ajGjJy/sRE9J@public.gmane.org>, Linux ARM Kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Rahul Sharma <rahul.sharma-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 18.03.2014 10:56, Cho KyongHo wrote:
> On Fri, 14 Mar 2014 13:59:00 +0100, Tomasz Figa wrote:
>> Hi KyongHo,
>>
>> On 14.03.2014 06:08, Cho KyongHo wrote:

[snip]

>>> -static bool __exynos_sysmmu_disable(struct sysmmu_drvdata *data)
>>> +static void __sysmmu_disable_nocount(struct sysmmu_drvdata *data)
>>
>> If you are changing the names anyway, it would be probably a good idea
>> to reduce code obfuscation a bit and drop the underscores from
>> beginnings of function names. Also I'd suggest keeping the "exynos_" prefix.
>
> Thanks for the suggestion.
> __exynos_sysmmu_disable is splitted into 2 functions: __sysmmu_disable
> and __sysmmu_disable_nocount.
> I agree with you that it is good idea to reduce code obfuscation but
> I don't think dropping beginning underscores of function names reduces
> obfuscation.
>

Well, if you are ending up with a function like 
__sysmmu_enable_nocount() below with every line starting with two 
underscores, do you think this improves code readability?

Of course this is a minor issue, but let's keep some code quality level 
in Linux kernel.

>>
>>>    {
>>> -	unsigned long flags;
>>> -	bool disabled = false;
>>> -
>>> -	write_lock_irqsave(&data->lock, flags);

[snip]

Here's the function mentioned above:

>>> +
>>> +static void __sysmmu_enable_nocount(struct sysmmu_drvdata *data)
>>> +{
>>> +	__master_clk_enable(data);
>>> +	__sysmmu_clk_enable(data);
>>> +
>>> +	__raw_writel(CTRL_BLOCK, data->sfrbase + REG_MMU_CTRL);
>>> +
>>> +	__sysmmu_init_config(data);
>>> +
>>> +	__sysmmu_set_ptbase(data->sfrbase, data->pgtable);
>>> +
>>> +	__raw_writel(CTRL_ENABLE, data->sfrbase + REG_MMU_CTRL);
>>> +
>>> +	__master_clk_disable(data);
>>> +}
>>> +

[snip]

>>>
>>> @@ -629,7 +700,7 @@ err_pgtable:
>>>    static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
>>>    {
>>>    	struct exynos_iommu_domain *priv = domain->priv;
>>> -	struct sysmmu_drvdata *data;
>>> +	struct exynos_iommu_owner *owner;
>>>    	unsigned long flags;
>>>    	int i;
>>>
>>> @@ -637,11 +708,14 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
>>>
>>>    	spin_lock_irqsave(&priv->lock, flags);
>>>
>>> -	list_for_each_entry(data, &priv->clients, node) {
>>> -		while (!exynos_sysmmu_disable(data->dev))
>>> +	list_for_each_entry(owner, &priv->clients, client) {
>>> +		while (!exynos_sysmmu_disable(owner->dev))
>>>    			; /* until System MMU is actually disabled */
>>
>> What about using list_for_each_entry_safe() and calling list_del_init()
>> here directly?
>>
>
> That require another variable to be defined.

Is it a problem?

> I just wanted to avoid that because I think it is prettier.
> Moreover, list_del_init() below the empty while() clause may make
> the source code readers misunderstood..

This raises another question, why the loop above is even needed. 
exynos_sysmmu_disable() should make sure that SYSMMU is actually 
disabled, without any need for looping like this.

>>>    	}
>>>
>>> +	while (!list_empty(&priv->clients))
>>> +		list_del_init(priv->clients.next);
>>> +
>>>    	spin_unlock_irqrestore(&priv->lock, flags);
>>>
>>>    	for (i = 0; i < NUM_LV1ENTRIES; i++)

[snip]

>>> +static int sysmmu_hook_driver_register(struct notifier_block *nb,
>>> +					unsigned long val,
>>> +					void *p)
>>> +{
>>> +	struct device *dev = p;
>>> +
>>> +	switch (val) {
>>> +	case BUS_NOTIFY_BIND_DRIVER:
>>> +	{
>>> +		struct exynos_iommu_owner *owner;
>>
>> Please move this variable to the top of the function and drop the braces
>> around case blocks.
>
> I don't think it is required because this function is modified
> by the following patches.

OK, if so, and similar issue is not present after further patches.

>
>>
>>> +
>>> +		/* No System MMU assigned. See exynos_sysmmu_probe(). */
>>> +		if (dev->archdata.iommu == NULL)
>>> +			break;
>>
>> This looks strange... (see below)
>>
>> Also this looks racy. There are no guarantees about device probing
>> order, so you may end up with master devices being probed before the
>> IOMMUs. Deferred probing should be used to handle this correctly.
>
> System MMU driver must be probed earlier than the drivers of master devices
> because the drivers may want to use System MMU for their initial task.

As I said, there are no guarantees about platform device probe order in 
Linux kernel. Code must be designed to check whether required 
dependencies are met and if not, deferred probing must be used.

>>
>>> +
>>> +		owner = devm_kzalloc(dev, sizeof(*owner), GFP_KERNEL);
>>> +		if (!owner) {
>>> +			dev_err(dev, "No Memory for exynos_iommu_owner\n");
>>> +			return -ENOMEM;
>>> +		}
>>> +
>>> +		owner->dev = dev;
>>> +		INIT_LIST_HEAD(&owner->client);
>>> +		owner->sysmmu = dev->archdata.iommu;
>>> +
>>> +		dev->archdata.iommu = owner;
>>
>> I don't understand what is happening here in this case statement. There
>> is already something assigned to dev->archdata.iommu, but this code
>> reassigns something else to this field. This means that you attempt to
>> use the same field to store pointers to objects of different types,
>> which I believe is broken, because you have no way to check what kind of
>> object is currently pointed by such (void *) pointer.
>>
>
> exynos_sysmmu_probe() assigns the device descriptor of the probing System MMU
> to archdata.iommu of its master device. The assignment is just a marker that
> the device is a master device of a System MMU.
> If dev->archdata.iommu has a value in the case of BUS_NOTIFY_BIND_DRIVER,
> the 'dev' is a master devices of a System MMU. Then sysmmu_hook_driver_register()
> assigns the data structure to handle System MMU to dev->archdata.iommu.

Which is wrong (or even if you don't consider it wrong, it is ugly), 
because one (void *) pointer in the same object is used to store 
pointers to two completely different types.

Best regards,
Tomasz
