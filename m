Return-Path: <SRS0=J3Yr=GZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E06C433E0
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:27:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E3EC235F7
	for <iommu@archiver.kernel.org>; Fri, 22 Jan 2021 13:27:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E3EC235F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BDD43228DB;
	Fri, 22 Jan 2021 13:27:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tzCgCo0g5m7G; Fri, 22 Jan 2021 13:27:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A428F2049D;
	Fri, 22 Jan 2021 13:27:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98053C08A1;
	Fri, 22 Jan 2021 13:27:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0DD48C013A
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id F0AB087284
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:27:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yUQCvtKTQ24l for <iommu@lists.linux-foundation.org>;
 Fri, 22 Jan 2021 13:27:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6927587275
 for <iommu@lists.linux-foundation.org>; Fri, 22 Jan 2021 13:27:02 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 71C9C23437;
 Fri, 22 Jan 2021 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611322022;
 bh=TFRhEbqOYGrPg5oqvZVpaacX5O5OSugUVOmvFlNjpHU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=WES5Cm1GzYFPymGEhfK8FTVVWR1u6M1vvW13aa9LwGcq3rhxId09iMjJocQDvk8hm
 iG1Sbab84JE57V4aIaKSycb5d1IxgqWLfDlpqcsYdlYW/r+3CFkyg5EZZPoi8pryad
 tfK1K/MHOVDOaiLC9aTyHscXWl+zhxwPiHHL0wBewy5GBjh8bQz84GgHpRSxOtNzgY
 /cz2yHVcmYMua4UV/bCQjZlA74eHzcPoyB3QGRvbfP/ssHCB/ADoBi3hcX1BkEEJIQ
 PX67b5+eXPGAwDZCS+35ypd0ENmdD27/qMkRwvBLLpU9w4GJyV02QzzSWzQqLVkKVE
 f6GtWRRs8geow==
Date: Fri, 22 Jan 2021 13:26:57 +0000
From: Will Deacon <will@kernel.org>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: add support for BBML
Message-ID: <20210122132657.GF24102@willie-the-truck>
References: <20201126034230.777-1-thunder.leizhen@huawei.com>
 <20210122125132.GB24102@willie-the-truck>
 <34a9c164-389d-30cd-11a3-8796eb7bca93@arm.com>
 <ad8cb736-6760-8aab-b11e-f296ec12301b@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad8cb736-6760-8aab-b11e-f296ec12301b@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Yang Yingliang <yangyingliang@huawei.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 iommu <iommu@lists.linux-foundation.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, Jan 22, 2021 at 09:21:20PM +0800, Leizhen (ThunderTown) wrote:
> On 2021/1/22 21:00, Robin Murphy wrote:
> > On 2021-01-22 12:51, Will Deacon wrote:
> >> On Thu, Nov 26, 2020 at 11:42:30AM +0800, Zhen Lei wrote:
> >>> =A0 -=A0=A0=A0=A0=A0=A0=A0 tblp =3D ptep - ARM_LPAE_LVL_IDX(iova, lvl=
, data);
> >>> -=A0=A0=A0=A0=A0=A0=A0 if (__arm_lpae_unmap(data, NULL, iova, sz, lvl=
, tblp) !=3D sz) {
> >>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WARN_ON(1);
> >>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
> >>> +=A0=A0=A0=A0=A0=A0=A0 switch (cfg->bbml) {
> >>> +=A0=A0=A0=A0=A0=A0=A0 case 0:
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * We need to unmap and free the=
 old table before
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * overwriting it with a block e=
ntry.
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 */
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tblp =3D ptep - ARM_LPAE_LVL_IDX(i=
ova, lvl, data);
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (__arm_lpae_unmap(data, NULL, i=
ova, sz, lvl, tblp) !=3D sz) {
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 WARN_ON(1);
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -EINVAL;
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> >>> +=A0=A0=A0=A0=A0=A0=A0 case 1:
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __arm_lpae_init_pte(data, paddr, p=
rot, lvl, ptep, ARM_LPAE_PTE_nT);
> >>> +
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 io_pgtable_tlb_flush_walk(iop, iov=
a, sz, ARM_LPAE_GRANULE(data));
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tblp =3D iopte_deref(pte, data);
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __arm_lpae_free_pgtable(data, lvl =
+ 1, tblp);
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 break;
> >>> +=A0=A0=A0=A0=A0=A0=A0 case 2:
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __arm_lpae_init_pte(data, paddr, p=
rot, lvl, ptep, 0);
> >>> +
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 io_pgtable_tlb_flush_walk(iop, iov=
a, sz, ARM_LPAE_GRANULE(data));
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tblp =3D iopte_deref(pte, data);
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 __arm_lpae_free_pgtable(data, lvl =
+ 1, tblp);
> >>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return 0;
> >>
> >> Sorry, but I really don't understand what you're trying to do here. Th=
e old
> >> code uses BBM for the table -> block path so we don't need anything ex=
tra
> >> here. The dodgy case is when we unmap part of a block, and end up inst=
alling
> >> a table via arm_lpae_split_blk_unmap(). We can't use BBM there because=
 there
> >> could be ongoing DMA to parts of the block mapping that we want to rem=
ain in
> >> place.
> >>
> >> Are you seeing a problem in practice?
> > =

> > Right, I was under the assumption that we could ignore BBML because we
> > should never have a legitimate reason to split blocks. I'm certainly not
> > keen on piling any more complexity into split_blk_unmap, because the
> > IOMMU API clearly doesn't have a well-defined behaviour for that case
> > anyway - some other drivers will just unmap the entire block, and IIRC
> > there was a hint somewhere in VFIO that it might actually expect that
> > behaviour.
> =

> I'm going home. I'll answer you two tomorrow.

It can wait until Monday! Have a good weekend :)

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
