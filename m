Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 078BDC2BB55
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 16:04:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEE82166E
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 16:04:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEE82166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9099286A48;
	Wed, 15 Apr 2020 16:04:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rFlHxcDxVbRq; Wed, 15 Apr 2020 16:04:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B6BA086B0E;
	Wed, 15 Apr 2020 16:04:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2C73C089E;
	Wed, 15 Apr 2020 16:04:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61289C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 16:04:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4A7E920358
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 16:04:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kwsCQMJzRFlO for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 16:04:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by silver.osuosl.org (Postfix) with ESMTP id 681502013C
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 16:04:34 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD6FF1FB;
 Wed, 15 Apr 2020 09:04:33 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com
 [10.1.196.255])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38A133F6C4;
 Wed, 15 Apr 2020 09:04:31 -0700 (PDT)
Date: Wed, 15 Apr 2020 17:04:25 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: Laurentiu Tudor <laurentiu.tudor@nxp.com>
Subject: Re: [RFC PATCH 1/4] bus: fsl-mc: add custom .dma_configure
 implementation
Message-ID: <20200415160425.GA6436@e121166-lin.cambridge.arm.com>
References: <20200227100542.13819-1-laurentiu.tudor@nxp.com>
 <20200325125109.GA5430@red-moon.cambridge.arm.com>
 <499fbf9a-416f-d7c7-0655-881d92138a6c@nxp.com>
 <20200414143211.GA14905@red-moon.cambridge.arm.com>
 <d37ca4e3-58cb-9d6f-3a98-5e4a21ca948b@nxp.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d37ca4e3-58cb-9d6f-3a98-5e4a21ca948b@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: jason@lakedaemon.net, calvin.johnson@nxp.com, ard.biesheuvel@linaro.org,
 maz@kernel.org, pankaj.bansal@nxp.com, diana.craciun@oss.nxp.com,
 jon@solid-run.com, linux-kernel@vger.kernel.org, jeremy.linton@arm.com,
 linux-acpi@vger.kernel.org, iommu@lists.linux-foundation.org,
 cristian.sovaiala@nxp.com, tglx@linutronix.de, makarand.pawagi@nxp.com,
 ioana.ciornei@nxp.com, Stuart.Yoder@arm.com, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org, V.Sethi@nxp.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Apr 15, 2020 at 06:44:37PM +0300, Laurentiu Tudor wrote:
> 
> 
> On 4/14/2020 5:32 PM, Lorenzo Pieralisi wrote:
> > On Wed, Mar 25, 2020 at 06:48:55PM +0200, Laurentiu Tudor wrote:
> >> Hi Lorenzo,
> >>
> >> On 3/25/2020 2:51 PM, Lorenzo Pieralisi wrote:
> >>> On Thu, Feb 27, 2020 at 12:05:39PM +0200, laurentiu.tudor@nxp.com wrote:
> >>>> From: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>>
> >>>> The devices on this bus are not discovered by way of device tree
> >>>> but by queries to the firmware. It makes little sense to trick the
> >>>> generic of layer into thinking that these devices are of related so
> >>>> that we can get our dma configuration. Instead of doing that, add
> >>>> our custom dma configuration implementation.
> >>>>
> >>>> Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> >>>> ---
> >>>>  drivers/bus/fsl-mc/fsl-mc-bus.c | 31 ++++++++++++++++++++++++++++++-
> >>>>  1 file changed, 30 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>> index 36eb25f82c8e..eafaa0e0b906 100644
> >>>> --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>> +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> >>>> @@ -132,11 +132,40 @@ static int fsl_mc_bus_uevent(struct device *dev, struct kobj_uevent_env *env)
> >>>>  static int fsl_mc_dma_configure(struct device *dev)
> >>>>  {
> >>>>  	struct device *dma_dev = dev;
> >>>> +	struct iommu_fwspec *fwspec;
> >>>> +	const struct iommu_ops *iommu_ops;
> >>>> +	struct fsl_mc_device *mc_dev = to_fsl_mc_device(dev);
> >>>> +	int ret;
> >>>> +	u32 icid;
> >>>>  
> >>>>  	while (dev_is_fsl_mc(dma_dev))
> >>>>  		dma_dev = dma_dev->parent;
> >>>>  
> >>>> -	return of_dma_configure(dev, dma_dev->of_node, 0);
> >>>> +	fwspec = dev_iommu_fwspec_get(dma_dev);
> >>>> +	if (!fwspec)
> >>>> +		return -ENODEV;
> >>>> +	iommu_ops = iommu_ops_from_fwnode(fwspec->iommu_fwnode);
> >>>> +	if (!iommu_ops)
> >>>> +		return -ENODEV;
> >>>> +
> >>>> +	ret = iommu_fwspec_init(dev, fwspec->iommu_fwnode, iommu_ops);
> >>>> +	if (ret)
> >>>> +		return ret;
> >>>> +
> >>>> +	icid = mc_dev->icid;
> >>>> +	ret = iommu_fwspec_add_ids(dev, &icid, 1);
> >>>
> >>> I see. So with this patch we would use the MC named component only to
> >>> retrieve the iommu_ops
> >>
> >> Right. I'd also add that the implementation tries to follow the existing
> >> standard .dma_configure implementations, e.g. of_dma_configure +
> >> of_iommu_configure. I'd also note that similarly to the ACPI case, this
> >> MC FW device is probed as a platform device in the DT scenario, binding
> >> here [1].
> >> A similar approach is used for the retrieval of the msi irq domain, see
> >> following patch.
> >>
> >>> - the streamid are injected directly here bypassing OF/IORT bindings translations altogether. 
> >>
> >> Actually I've submitted a v2 [2] that calls into .of_xlate() to allow
> >> the smmu driver to do some processing on the raw streamid coming from
> >> the firmware. I have not yet tested this with ACPI but expect it to
> >> work, however, it's debatable how valid is this approach in the context
> >> of ACPI.
> > 
> > Actually, what I think you need is of_map_rid() (and an IORT
> > equivalent, that I am going to write - generalizing iort_msi_map_rid()).
> > 
> > Would that be enough to enable IORT "normal" mappings in the MC bus
> > named components ?
> > 
> 
> At a first glance, looks like this could very well fix the ACPI
> scenario, but I have some unclarities on the approach:
>  * are we going to rely in DT and ACPI generic layers even if these
> devices are not published / enumerated through DT or ACPI tables?
>  * the firmware manages and provides discrete streamids for the devices
> it exposes so there's no translation involved. There's no
>    requestor_id / input_id involved but it seems that we would still do
> some kind of translation relying for this on the DT/ACPI functions.
>  * MC firmware has its own stream_id (e.g. on some chips 0x4000, others
> 0xf00, so outside the range of stream_ids used for the mc devices)
>    while for the devices on this bus, MC allocates stream_ids from a
> range (e.g. 0x17 - 0x3f). Is it possible to describe this in the IORT table?
>  * Regarding the of_map_rid() use you mentioned, I was planning to
> decouple the mc bus from the DT layer by dropping the use of
> of_map_rid(), see patch 4.
> I briefly glanced over the iort code and spotted this static function:
> iort_iommu_xlate(). Wouldn't it also help, of course after making it public?

Guys I have lost you honestly. I don't understand what you really need
to do with DT and ACPI here. Are they needed to describe what you need
or not ? If the MC dma configure function does not need any DT/ACPI
bindings that's fine by me, I don't understand though why you are still
asking how to represent MC in ACPI then, what for.

Can you talk between *yourselves* please and decide what you need ?

What's the problem ?

Thanks,
Lorenzo
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
