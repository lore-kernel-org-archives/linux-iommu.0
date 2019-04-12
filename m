Return-Path: <SRS0=HOzV=SO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139ADC10F0E
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 13:11:40 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1D420850
	for <iommu@archiver.kernel.org>; Fri, 12 Apr 2019 13:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1D420850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 95EDA14D5;
	Fri, 12 Apr 2019 13:11:39 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 87354135E
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 13:11:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id AF116F4
	for <iommu@lists.linux-foundation.org>;
	Fri, 12 Apr 2019 13:11:37 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B799374;
	Fri, 12 Apr 2019 06:11:37 -0700 (PDT)
Received: from [10.1.196.75] (e110467-lin.cambridge.arm.com [10.1.196.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B38C63F68F;
	Fri, 12 Apr 2019 06:11:32 -0700 (PDT)
Subject: Re: [PATCH v5 1/6] iommu: add generic boot option iommu.dma_mode
To: John Garry <john.garry@huawei.com>, Zhen Lei <thunder.leizhen@huawei.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	Will Deacon <will.deacon@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc <linux-doc@vger.kernel.org>,
	Sebastian Ott <sebott@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
	Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
	David Woodhouse <dwmw2@infradead.org>,
	iommu <iommu@lists.linux-foundation.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-s390 <linux-s390@vger.kernel.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, x86 <x86@kernel.org>,
	linux-ia64 <linux-ia64@vger.kernel.org>
References: <20190409125308.18304-1-thunder.leizhen@huawei.com>
	<20190409125308.18304-2-thunder.leizhen@huawei.com>
	<010d3cbd-ef74-ad21-c735-0af8b18955e6@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <222946ee-adcc-1311-82a7-6afc9ffbc846@arm.com>
Date: Fri, 12 Apr 2019 14:11:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <010d3cbd-ef74-ad21-c735-0af8b18955e6@huawei.com>
Content-Language: en-GB
Cc: Hanjun Guo <guohanjun@huawei.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="windows-1252"; Format="flowed"
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On 12/04/2019 11:26, John Garry wrote:
> On 09/04/2019 13:53, Zhen Lei wrote:
>> Currently the IOMMU dma contains 3 modes: passthrough, lazy, strict. The
>> passthrough mode bypass the IOMMU, the lazy mode defer the invalidation
>> of hardware TLBs, and the strict mode invalidate IOMMU hardware TLBs
>> synchronously. The three modes are mutually exclusive. But the current
>> boot options are confused, such as: iommu.passthrough and iommu.strict,
>> because they are no good to be coexist. So add iommu.dma_mode.
>>
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>> =A0Documentation/admin-guide/kernel-parameters.txt | 19 ++++++++
>> =A0drivers/iommu/iommu.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 59 =

>> ++++++++++++++++++++-----
>> =A0include/linux/iommu.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 5 +++
>> =A03 files changed, 71 insertions(+), 12 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt =

>> b/Documentation/admin-guide/kernel-parameters.txt
>> index 2b8ee90bb64470d..f7766f8ac8b9084 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -1811,6 +1811,25 @@
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1 - Bypass the IOMMU for DMA.
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 unset - Use value of CONFIG_IOMMU_D=
EFAULT_PASSTHROUGH.
>>
>> +=A0=A0=A0 iommu.dma_mode=3D Configure default dma mode. if unset, use t=
he value
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of CONFIG_IOMMU_DEFAULT_PASSTHROUGH t=
o determine
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 passthrough or not.
> =

> To me, for unset it's unclear what we default to. So if unset and also =

> CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set, do we get lazy or strict =

> mode? (note: I'm ignoring backwards compatibility and interaction of =

> iommu.strict and .passthorugh also, more below).
> =

> Could we considering introducing config DEFAULT_IOMMU_DMA_MODE, similar =

> to DEFAULT_IOSCHED?

Yes, what I was suggesting was specifically refactoring the Kconfig =

options into a single choice that controls the default (i.e. no command =

line option provided) behaviour. AFAICS it should be fairly =

straightforward to maintain the existing "strict" and "passthrough" =

options (and legacy arch-specific versions thereof) to override that =

default without introducing yet another command-line option, which I =

think we should avoid if possible.
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Note: For historical reasons, ARM64/S=
390/PPC/X86 have
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 their specific options. Currently, on=
ly ARM64 support
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 this boot option, and hope other ARCH=
s to use this as
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 generic boot option.
>> +=A0=A0=A0=A0=A0=A0=A0 passthrough
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Configure DMA to bypass the IOMMU by =
default.
>> +=A0=A0=A0=A0=A0=A0=A0 lazy
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Request that DMA unmap operations use=
 deferred
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 invalidation of hardware TLBs, for in=
creased
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 throughput at the cost of reduced dev=
ice isolation.
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Will fall back to strict mode if not =
supported by
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 the relevant IOMMU driver.
>> +=A0=A0=A0=A0=A0=A0=A0 strict
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DMA unmap operations invalidate IOMMU=
 hardware TLBs
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 synchronously.
>> +
>> =A0=A0=A0=A0 io7=3D=A0=A0=A0=A0=A0=A0=A0 [HW] IO7 for Marvel based alpha=
 systems
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 See comment before marvel_specify_i=
o7 in
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 arch/alpha/kernel/core_marvel.c.
>> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
>> index 109de67d5d727c2..df1ce8e22385b48 100644
>> --- a/drivers/iommu/iommu.c
>> +++ b/drivers/iommu/iommu.c
>> @@ -38,12 +38,13 @@
>>
>> =A0static struct kset *iommu_group_kset;
>> =A0static DEFINE_IDA(iommu_group_ida);
>> +
>> =A0#ifdef CONFIG_IOMMU_DEFAULT_PASSTHROUGH
>> -static unsigned int iommu_def_domain_type =3D IOMMU_DOMAIN_IDENTITY;
>> +#define IOMMU_DEFAULT_DMA_MODE=A0=A0=A0=A0=A0=A0=A0 IOMMU_DMA_MODE_PASS=
THROUGH
>> =A0#else
>> -static unsigned int iommu_def_domain_type =3D IOMMU_DOMAIN_DMA;
>> +#define IOMMU_DEFAULT_DMA_MODE=A0=A0=A0=A0=A0=A0=A0 IOMMU_DMA_MODE_STRI=
CT
>> =A0#endif
>> -static bool iommu_dma_strict __read_mostly =3D true;
>> +static int iommu_default_dma_mode __read_mostly =3D =

>> IOMMU_DEFAULT_DMA_MODE;
>>
>> =A0struct iommu_callback_data {
>> =A0=A0=A0=A0 const struct iommu_ops *ops;
>> @@ -147,20 +148,51 @@ static int __init iommu_set_def_domain_type(char =

>> *str)
>> =A0=A0=A0=A0 int ret;
>>
>> =A0=A0=A0=A0 ret =3D kstrtobool(str, &pt);
>> -=A0=A0=A0 if (ret)
>> -=A0=A0=A0=A0=A0=A0=A0 return ret;
>> +=A0=A0=A0 if (!ret && pt)
>> +=A0=A0=A0=A0=A0=A0=A0 iommu_default_dma_mode =3D IOMMU_DMA_MODE_PASSTHR=
OUGH;
>>
>> -=A0=A0=A0 iommu_def_domain_type =3D pt ? IOMMU_DOMAIN_IDENTITY : =

>> IOMMU_DOMAIN_DMA;
>> -=A0=A0=A0 return 0;
>> +=A0=A0=A0 return ret;
>> =A0}
>> =A0early_param("iommu.passthrough", iommu_set_def_domain_type);
>>
>> =A0static int __init iommu_dma_setup(char *str)
>> =A0{
>> -=A0=A0=A0 return kstrtobool(str, &iommu_dma_strict);
>> +=A0=A0=A0 bool strict;
>> +=A0=A0=A0 int ret;
>> +
>> +=A0=A0=A0 ret =3D kstrtobool(str, &strict);
>> +=A0=A0=A0 if (!ret)
>> +=A0=A0=A0=A0=A0=A0=A0 iommu_default_dma_mode =3D strict ?
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IOMMU_DMA_MODE_STRICT : I=
OMMU_DMA_MODE_LAZY;
>> +
>> +=A0=A0=A0 return ret;
>> =A0}
>> =A0early_param("iommu.strict", iommu_dma_setup);
>>
>> +static int __init iommu_dma_mode_setup(char *str)
>> +{
>> +=A0=A0=A0 if (!str)
>> +=A0=A0=A0=A0=A0=A0=A0 goto fail;
>> +
>> +=A0=A0=A0 if (!strncmp(str, "passthrough", 11))
>> +=A0=A0=A0=A0=A0=A0=A0 iommu_default_dma_mode =3D IOMMU_DMA_MODE_PASSTHR=
OUGH;
>> +=A0=A0=A0 else if (!strncmp(str, "lazy", 4))
>> +=A0=A0=A0=A0=A0=A0=A0 iommu_default_dma_mode =3D IOMMU_DMA_MODE_LAZY;
>> +=A0=A0=A0 else if (!strncmp(str, "strict", 6))
>> +=A0=A0=A0=A0=A0=A0=A0 iommu_default_dma_mode =3D IOMMU_DMA_MODE_STRICT;
>> +=A0=A0=A0 else
>> +=A0=A0=A0=A0=A0=A0=A0 goto fail;
>> +
>> +=A0=A0=A0 pr_info("Force dma mode to be %d\n", iommu_default_dma_mode);
> =

> What happens if the cmdline option iommu.dma_mode is passed multiple =

> times? We get mutliple - possibily conflicting - prints, right?

Indeed; we ended up removing such prints for the existing options here, =

specifically because multiple messages seemed more likely to be =

confusing than useful.

> And do we need to have backwards compatibility, such that the setting =

> for iommu.strict or iommu.passthrough trumps iommu.dma_mode, regardless =

> of order?

As above I think it would be preferable to just keep using the existing =

options anyway. The current behaviour works out as:

iommu.passthrough |      Y	|	  N
iommu.strict	  |      x	|    Y         N
------------------|-------------|---------|--------
MODE		  | PASSTHROUGH | STRICT  |  LAZY

which seems intuitive enough that a specific dma_mode option doesn't add =

much value, and would more likely just overcomplicate things for users =

as well as our implementation.

Robin.

>> +
>> +=A0=A0=A0 return 0;
>> +
>> +fail:
>> +=A0=A0=A0 pr_debug("Boot option iommu.dma_mode is incorrect, ignored\n"=
);
>> +=A0=A0=A0 return -EINVAL;
>> +}
>> +early_param("iommu.dma_mode", iommu_dma_mode_setup);
>> +
>> =A0static ssize_t iommu_group_attr_show(struct kobject *kobj,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct a=
ttribute *__attr, char *buf)
>> =A0{
>> @@ -1102,14 +1134,17 @@ struct iommu_group =

>> *iommu_group_get_for_dev(struct device *dev)
>> =A0=A0=A0=A0=A0 */
>> =A0=A0=A0=A0 if (!group->default_domain) {
>> =A0=A0=A0=A0=A0=A0=A0=A0 struct iommu_domain *dom;
>> +=A0=A0=A0=A0=A0=A0=A0 int def_domain_type =3D
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 (iommu_default_dma_mode =3D=3D IOMMU_=
DMA_MODE_PASSTHROUGH)
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ? IOMMU_DOMAIN_IDENTITY : IOMMU_DOMAI=
N_DMA;
>>
>> -=A0=A0=A0=A0=A0=A0=A0 dom =3D __iommu_domain_alloc(dev->bus, iommu_def_=
domain_type);
>> -=A0=A0=A0=A0=A0=A0=A0 if (!dom && iommu_def_domain_type !=3D IOMMU_DOMA=
IN_DMA) {
>> +=A0=A0=A0=A0=A0=A0=A0 dom =3D __iommu_domain_alloc(dev->bus, def_domain=
_type);
>> +=A0=A0=A0=A0=A0=A0=A0 if (!dom && def_domain_type !=3D IOMMU_DOMAIN_DMA=
) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dom =3D __iommu_domain_alloc(dev->b=
us, IOMMU_DOMAIN_DMA);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (dom) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_warn(dev,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "failed =
to allocate default IOMMU domain of type =

>> %u; falling back to IOMMU_DOMAIN_DMA",
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iommu_def_=
domain_type);
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 def_domain=
_type);
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
>> =A0=A0=A0=A0=A0=A0=A0=A0 }
>>
>> @@ -1117,7 +1152,7 @@ struct iommu_group =

>> *iommu_group_get_for_dev(struct device *dev)
>> =A0=A0=A0=A0=A0=A0=A0=A0 if (!group->domain)
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 group->domain =3D dom;
>>
>> -=A0=A0=A0=A0=A0=A0=A0 if (dom && !iommu_dma_strict) {
>> +=A0=A0=A0=A0=A0=A0=A0 if (dom && (iommu_default_dma_mode =3D=3D IOMMU_D=
MA_MODE_LAZY)) {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int attr =3D 1;
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iommu_domain_set_attr(dom,
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
>> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
>> index ffbbc7e39ceeba3..c3f4e3416176496 100644
>> --- a/include/linux/iommu.h
>> +++ b/include/linux/iommu.h
>> @@ -42,6 +42,11 @@
>> =A0 */
>> =A0#define IOMMU_PRIV=A0=A0=A0 (1 << 5)
>>
>> +
>> +#define IOMMU_DMA_MODE_STRICT=A0=A0=A0=A0=A0=A0=A0 0x0
>> +#define IOMMU_DMA_MODE_LAZY=A0=A0=A0=A0=A0=A0=A0 0x1
>> +#define IOMMU_DMA_MODE_PASSTHROUGH=A0=A0=A0 0x2
>> +
>> =A0struct iommu_ops;
>> =A0struct iommu_group;
>> =A0struct bus_type;
>>
> =

> =

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
