Return-Path: <SRS0=MQAj=7J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B19C433E0
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 12:11:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1FC620657
	for <iommu@archiver.kernel.org>; Wed, 27 May 2020 12:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1FC620657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id B4A1B2045E;
	Wed, 27 May 2020 12:11:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YadJ+K6pRZ6G; Wed, 27 May 2020 12:11:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 74663203FB;
	Wed, 27 May 2020 12:11:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 55167C0881;
	Wed, 27 May 2020 12:11:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A23EBC016F
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 07:07:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 891B18768A
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 07:07:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HuOszzFe8res for <iommu@lists.linux-foundation.org>;
 Wed, 27 May 2020 07:07:34 +0000 (UTC)
X-Greylist: delayed 00:20:59 by SQLgrey-1.7.6
Received: from huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6129087653
 for <iommu@lists.linux-foundation.org>; Wed, 27 May 2020 07:07:33 +0000 (UTC)
Received: from DGGEMM403-HUB.china.huawei.com (unknown [172.30.72.56])
 by Forcepoint Email with ESMTP id 35613D2FADC08F94C152;
 Wed, 27 May 2020 14:46:32 +0800 (CST)
Received: from DGGEMM424-HUB.china.huawei.com (10.1.198.41) by
 DGGEMM403-HUB.china.huawei.com (10.3.20.211) with Microsoft SMTP Server (TLS)
 id 14.3.487.0; Wed, 27 May 2020 14:46:31 +0800
Received: from DGGEMM506-MBX.china.huawei.com ([169.254.3.4]) by
 dggemm424-hub.china.huawei.com ([10.1.198.41]) with mapi id 14.03.0487.000;
 Wed, 27 May 2020 14:46:25 +0800
From: "Zengtao (B)" <prime.zeng@hisilicon.com>
To: "zhengxiang (A)" <zhengxiang9@huawei.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>
Subject: RE: [RFC] Use SMMU HTTU for DMA dirty page tracking
Thread-Topic: [RFC] Use SMMU HTTU for DMA dirty page tracking
Thread-Index: AQHWLcHpdMO0bbYbEkW2sovVw/ZxjKiz12IAgARX1wCAA1ZFUA==
Date: Wed, 27 May 2020 06:46:24 +0000
Message-ID: <678F3D1BB717D949B966B68EAEB446ED4146A6E4@DGGEMM506-MBX.china.huawei.com>
References: <b926ec0b-fe87-0792-c41d-acad56c656a4@huawei.com>
 <20200522171452.GC3453945@myrica>
 <e68c1158-8573-a477-42ce-48cee510c3ce@huawei.com>
In-Reply-To: <e68c1158-8573-a477-42ce-48cee510c3ce@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.74.221.187]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Mailman-Approved-At: Wed, 27 May 2020 12:11:16 +0000
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Suzuki K Poulose <suzuki.poulose@arm.com>,
 "maz@kernel.org" <maz@kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Kirti Wankhede <kwankhede@nvidia.com>, James Morse <james.morse@arm.com>,
 "julien.thierry.kdev@gmail.com" <julien.thierry.kdev@gmail.com>, "Wanghaibin
 \(D\)" <wanghaibin.wang@huawei.com>, Will Deacon <will@kernel.org>,
 "kvmarm@lists.cs.columbia.edu" <kvmarm@lists.cs.columbia.edu>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
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

> -----Original Message-----
> From: zhengxiang (A)
> Sent: Monday, May 25, 2020 7:34 PM
> To: Jean-Philippe Brucker
> Cc: linux-arm-kernel@lists.infradead.org; kvmarm@lists.cs.columbia.edu;
> Will Deacon; Wanghaibin (D); Zengtao (B); maz@kernel.org; James Morse;
> julien.thierry.kdev@gmail.com; Suzuki K Poulose; Wangzhou (B);
> iommu@lists.linux-foundation.org; Kirti Wankhede; Yan Zhao;
> alex.williamson@redhat.com
> Subject: Re: [RFC] Use SMMU HTTU for DMA dirty page tracking
> 
> [+cc Kirti, Yan, Alex]
> 
> On 2020/5/23 1:14, Jean-Philippe Brucker wrote:
> > Hi,
> >
> > On Tue, May 19, 2020 at 05:42:55PM +0800, Xiang Zheng wrote:
> >> Hi all,
> >>
> >> Is there any plan for enabling SMMU HTTU?
> >
> > Not outside of SVA, as far as I know.
> >
> 
> >> I have seen the patch locates in the SVA series patch, which adds
> >> support for HTTU:
> >>     https://www.spinics.net/lists/arm-kernel/msg798694.html
> >>
> >> HTTU reduces the number of access faults on SMMU fault queue
> >> (permission faults also benifit from it).
> >>
> >> Besides reducing the faults, HTTU also helps to track dirty pages for
> >> device DMA. Is it feasible to utilize HTTU to get dirty pages on device
> >> DMA during VFIO live migration?
> >
> > As you know there is a VFIO interface for this under discussion:
> >
> https://lore.kernel.org/kvm/1589781397-28368-1-git-send-email-kwankhe
> de@nvidia.com/
> > It doesn't implement an internal API to communicate with the IOMMU
> driver
> > about dirty pages.
> 
> >
> >> If SMMU can track dirty pages, devices are not required to implement
> >> additional dirty pages tracking to support VFIO live migration.
> >
> > It seems feasible, though tracking it in the device might be more
> > efficient. I might have misunderstood but I think for live migration of
> > the Intel NIC they trap guest accesses to the device and introspect its
> > state to figure out which pages it is accessing.
> >
> > With HTTU I suppose (without much knowledge about live migration)
> that
> > you'd need several new interfaces to the IOMMU drivers:
> >
> > * A way for VFIO to query HTTU support in the SMMU. There are some
> >   discussions about communicating more IOMMU capabilities through
> VFIO but
> >   no implementation yet. When HTTU isn't supported the DIRTY_PAGES
> bitmap
> >   would report all pages as they do now.
> >
> > * VFIO_IOMMU_DIRTY_PAGES_FLAG_START/STOP would clear the dirty
> bit
> >   for all VFIO mappings (which is going to take some time). There is a
> >   walker in io-pgtable for iova_to_phys() which could be extended. I
> >   suppose it's also possible to atomically switch the HA and HD bits in
> >   context descriptors.
> 
> Maybe we need not switch HA and HD bits, just turn on them all the time?

I think we need START/STOP, start is called when migration is started and STOP
called when migration finished.

I think you mean that during the migration(between START and STOP), HA and HD
functionality is always turned on.

> 
> >
> > * VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP would query the
> dirty bit for all
> >   VFIO mappings.
> >
We need a clear during the query which mean we have to reset the dirty status 
after a query.

> 
> I think we need to consider the case of IOMMU dirty pages logging. We
> want
> to test Kirti's VFIO migration patches combined with SMMU HTTU, any
> suggestions?

@kirti @yan @alex
As we know, you have worked on this feature for a long time, and it seems that
 everything is going very well now, thanks very much for your VFIO migration 
framework, it really helps a lot, and we want to start with SMMU HTTU enabled
 based on your jobs, it's kind of hardware dirty page tracking, and expected to bring us
 better performance, any suggestions? 

Thank you.
Zengtao 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
