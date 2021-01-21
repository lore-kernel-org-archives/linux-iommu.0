Return-Path: <SRS0=oIyp=GY=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20FEC433DB
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 18:14:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 252E023A56
	for <iommu@archiver.kernel.org>; Thu, 21 Jan 2021 18:14:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 252E023A56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A311E86D69;
	Thu, 21 Jan 2021 18:14:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bx9JA3BLa6CT; Thu, 21 Jan 2021 18:14:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id C238086D5E;
	Thu, 21 Jan 2021 18:14:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8080C08A1;
	Thu, 21 Jan 2021 18:14:27 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86EECC013A
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 18:14:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5ACF3204C9
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 18:14:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MVA5duesbYBK for <iommu@lists.linux-foundation.org>;
 Thu, 21 Jan 2021 18:14:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 092DA204A8
 for <iommu@lists.linux-foundation.org>; Thu, 21 Jan 2021 18:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611252863;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEgMkUTOCJsoedIDEpBA2hjPtpKSlnIAkYz8Z2MMNg0=;
 b=HhV9sQ15u8xtMOCvc5f7XYyaKls4zmWZ3XnrKGBi8SLVsOj0ainwS2r11PbitDq/PEEzgD
 EE2r0OTfgQI7XSyaey4DEEolQZQK7q73EAJFV4O+cZdnE5kR1jFKNnNreppBZcyS+lSnkI
 4BgDr7WmTT+vV4pVuOb0T52Anx48y6E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-4sowHxENOA-jNF3X_XPxfw-1; Thu, 21 Jan 2021 13:14:19 -0500
X-MC-Unique: 4sowHxENOA-jNF3X_XPxfw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 87956107ACE3;
 Thu, 21 Jan 2021 18:14:16 +0000 (UTC)
Received: from omen.home.shazbot.org (ovpn-112-255.phx2.redhat.com
 [10.3.112.255])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1251139A63;
 Thu, 21 Jan 2021 18:14:15 +0000 (UTC)
Date: Thu, 21 Jan 2021 11:14:14 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Keqian Zhu <zhukeqian1@huawei.com>
Subject: Re: [PATCH v2 2/2] vfio/iommu_type1: Sanity check pfn_list when
 remove vfio_dma
Message-ID: <20210121111414.143e3e4e@omen.home.shazbot.org>
In-Reply-To: <32f8b347-587a-1a9a-bee8-569f09a03a15@huawei.com>
References: <20210115092643.728-1-zhukeqian1@huawei.com>
 <20210115092643.728-3-zhukeqian1@huawei.com>
 <20210115121447.54c96857@omen.home.shazbot.org>
 <32f8b347-587a-1a9a-bee8-569f09a03a15@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: Mark
 Rutland <mark.rutland@arm.com>, jiangkunkun@huawei.com, kvm@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Kirti Wankhede <kwankhede@nvidia.com>, Will Deacon <will@kernel.org>,
 kvmarm@lists.cs.columbia.edu, Marc
 Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 wanghaibin.wang@huawei.com, Julien Thierry <julien.thierry.kdev@gmail.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Alexios Zavras <alexios.zavras@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, James Morse <james.morse@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>, Robin
 Murphy <robin.murphy@arm.com>
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

On Mon, 18 Jan 2021 21:16:08 +0800
Keqian Zhu <zhukeqian1@huawei.com> wrote:

> On 2021/1/16 3:14, Alex Williamson wrote:
> > On Fri, 15 Jan 2021 17:26:43 +0800
> > Keqian Zhu <zhukeqian1@huawei.com> wrote:
> >   
> >> vfio_sanity_check_pfn_list() is used to check whether pfn_list of
> >> vfio_dma is empty when remove the external domain, so it makes a
> >> wrong assumption that only external domain will add pfn to dma pfn_list.
> >>
> >> Now we apply this check when remove a specific vfio_dma and extract
> >> the notifier check just for external domain.  
> > 
> > The page pinning interface is gated by having a notifier registered for
> > unmaps, therefore non-external domains would also need to register a
> > notifier.  There's currently no other way to add entries to the
> > pfn_list.  So if we allow pinning for such domains, then it's wrong to
> > WARN_ON() when the notifier list is not-empty when removing an external
> > domain.  Long term we should probably extend page {un}pinning for the
> > caller to pass their notifier to be validated against the notifier list
> > rather than just allowing page pinning if *any* notifier is registered.
> > Thanks,  
> I was misled by the code comments. So when the commit a54eb55045ae is
> added, the only user of pin interface is mdev vendor driver, but now
> we also allow iommu backed group to use this interface to constraint
> dirty scope. Is vfio_iommu_unmap_unpin_all() a proper place to put
> this WARN()?

vfio_iommu_unmap_unpin_all() deals with removing vfio_dmas, it's
logically unrelated to whether any driver is registered to receive
unmap notifications.  Thanks,

Alex

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
