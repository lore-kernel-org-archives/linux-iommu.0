From: Tomasz Figa <t.figa-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v11 17/27] iommu/exynos: remove calls to Runtime PM API
	functions
Date: Wed, 19 Mar 2014 14:12:55 +0100
Message-ID: <532997D7.6090608@samsung.com>
References: <20140314140843.ba055f28dd7ed59c46088029@samsung.com>
	<5322FD14.5090602@samsung.com>
	<20140318185605.0380c8dfe6559c06183092e5@samsung.com>
	<532861BE.7020601@samsung.com>
	<20140319100304.5e26fa43ccdfc29178b058e1@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-reply-to: <20140319100304.5e26fa43ccdfc29178b058e1-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
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

On 19.03.2014 02:03, Cho KyongHo wrote:
> On Tue, 18 Mar 2014 16:09:50 +0100, Tomasz Figa wrote:
>> On 18.03.2014 10:56, Cho KyongHo wrote:
>>> On Fri, 14 Mar 2014 13:59:00 +0100, Tomasz Figa wrote:
>>>> Hi KyongHo,
>>>>
>>>> On 14.03.2014 06:08, Cho KyongHo wrote:

[snip]

>>>>> @@ -637,11 +708,14 @@ static void exynos_iommu_domain_destroy(struct iommu_domain *domain)
>>>>>
>>>>>     	spin_lock_irqsave(&priv->lock, flags);
>>>>>
>>>>> -	list_for_each_entry(data, &priv->clients, node) {
>>>>> -		while (!exynos_sysmmu_disable(data->dev))
>>>>> +	list_for_each_entry(owner, &priv->clients, client) {
>>>>> +		while (!exynos_sysmmu_disable(owner->dev))
>>>>>     			; /* until System MMU is actually disabled */
>>>>
>>>> What about using list_for_each_entry_safe() and calling list_del_init()
>>>> here directly?
>>>>
>>>
>>> That require another variable to be defined.
>>
>> Is it a problem?
>>
> That is not a problem.
> But I think using list_for_each_entry() is not a problem likewise.
>
>>> I just wanted to avoid that because I think it is prettier.
>>> Moreover, list_del_init() below the empty while() clause may make
>>> the source code readers misunderstood..
>>
>> This raises another question, why the loop above is even needed.
>> exynos_sysmmu_disable() should make sure that SYSMMU is actually
>> disabled, without any need for looping like this.
>
> Some driver needs enabling sysmmu to be counted due to its complex structure.
> It can be also removed by the driver with an extra effort
> but the reality is important.

My comment was not about the need to have reference counting, as this is 
a common design pattern, but rather that there should be a low level 
power control function, which simply disables the IOMMU, without the 
need to loop through existing references.

Actually there is already such function - __sysmmu_disable_nocount() - 
so the code could look like:

	list_for_each_entry_safe(owner, n, &priv->clients, client) {
		__sysmmu_disable_nocount(owner->dev);
		list_del_init(&owner->client);
	}

As for reference counting in this use case in general, as far as I'm 
looking through the whole driver code, there is no other usage of this 
reference counting than exynos_iommu_attach_device() and 
exynos_iommu_detach_device(). Assuming that there is just a single 
master for each SYSMMU, I don't see why reference counting is even 
needed, as you can't bind a device to IOMMU multiple times.

> Device driver is not only for the scholarship but also for the real use.

Huh? I'm not sure what kind of comment is this.

>
>>>>>     	}
>>>>>
>>>>> +	while (!list_empty(&priv->clients))
>>>>> +		list_del_init(priv->clients.next);
>>>>> +
>>>>>     	spin_unlock_irqrestore(&priv->lock, flags);
>>>>>
>>>>>     	for (i = 0; i < NUM_LV1ENTRIES; i++)
>>
>> [snip]
>>
>>>>> +static int sysmmu_hook_driver_register(struct notifier_block *nb,
>>>>> +					unsigned long val,
>>>>> +					void *p)
>>>>> +{
>>>>> +	struct device *dev = p;
>>>>> +
>>>>> +	switch (val) {
>>>>> +	case BUS_NOTIFY_BIND_DRIVER:
>>>>> +	{
>>>>> +		struct exynos_iommu_owner *owner;
>>>>
>>>> Please move this variable to the top of the function and drop the braces
>>>> around case blocks.
>>>
>>> I don't think it is required because this function is modified
>>> by the following patches.
>>
>> OK, if so, and similar issue is not present after further patches.
>>
>>>
>>>>
>>>>> +
>>>>> +		/* No System MMU assigned. See exynos_sysmmu_probe(). */
>>>>> +		if (dev->archdata.iommu == NULL)
>>>>> +			break;
>>>>
>>>> This looks strange... (see below)
>>>>
>>>> Also this looks racy. There are no guarantees about device probing
>>>> order, so you may end up with master devices being probed before the
>>>> IOMMUs. Deferred probing should be used to handle this correctly.
>>>
>>> System MMU driver must be probed earlier than the drivers of master devices
>>> because the drivers may want to use System MMU for their initial task.
>>
>> As I said, there are no guarantees about platform device probe order in
>> Linux kernel. Code must be designed to check whether required
>> dependencies are met and if not, deferred probing must be used.
>>
>
> I told that System MMU driver must be probed earlier.
> That's why exynos_iommu_init() is called by subsys_initcall level.
> I also noticed that it must be promoted to arch_initcall for some driver.
>

No. Proper Linux drivers must support deferred probing mechanism and 
there should be no assumptions about probing orders. Using other 
initcall level than module_initcall for particular drivers is strongly 
discouraged.

>>>>
>>>>> +
>>>>> +		owner = devm_kzalloc(dev, sizeof(*owner), GFP_KERNEL);
>>>>> +		if (!owner) {
>>>>> +			dev_err(dev, "No Memory for exynos_iommu_owner\n");
>>>>> +			return -ENOMEM;
>>>>> +		}
>>>>> +
>>>>> +		owner->dev = dev;
>>>>> +		INIT_LIST_HEAD(&owner->client);
>>>>> +		owner->sysmmu = dev->archdata.iommu;
>>>>> +
>>>>> +		dev->archdata.iommu = owner;
>>>>
>>>> I don't understand what is happening here in this case statement. There
>>>> is already something assigned to dev->archdata.iommu, but this code
>>>> reassigns something else to this field. This means that you attempt to
>>>> use the same field to store pointers to objects of different types,
>>>> which I believe is broken, because you have no way to check what kind of
>>>> object is currently pointed by such (void *) pointer.
>>>>
>>>
>>> exynos_sysmmu_probe() assigns the device descriptor of the probing System MMU
>>> to archdata.iommu of its master device. The assignment is just a marker that
>>> the device is a master device of a System MMU.
>>> If dev->archdata.iommu has a value in the case of BUS_NOTIFY_BIND_DRIVER,
>>> the 'dev' is a master devices of a System MMU. Then sysmmu_hook_driver_register()
>>> assigns the data structure to handle System MMU to dev->archdata.iommu.
>>
>> Which is wrong (or even if you don't consider it wrong, it is ugly),
>> because one (void *) pointer in the same object is used to store
>> pointers to two completely different types.
>
> archdata.iommu has a pointer to sysmmu descriptor for a very short time
> during booting time to build complete data structure to handle System MMU.
> It is it also a matter?

Yes. It is a serious issue from code readability point of view, as you 
don't know what kind of object pointed by this pointer to expect when 
reading the driver.

Keep in mind that readability is one of the key factors affecting driver 
maintainability which is important if the driver is intended to be kept 
in mainline for many Linux kernel releases, adding support for new 
hardware variants and keeping the driver in good shape over future 
kernel changes (e.g. large refactors of upper layers, such as IOMMU 
subsystem).

>
> Anyway, this style of initialization just maintained to make the driver work
> with the old design. It is changed with the following patches.

OK. If this is just a temporary step, then I guess we can ignore this 
issue. I just noted that such usage is a problem in general.

Best regards,
Tomasz
