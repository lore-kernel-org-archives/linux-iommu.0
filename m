Return-Path: <SRS0=tZpB=NH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D0AC4338F
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 08:21:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D4B61B1B
	for <iommu@archiver.kernel.org>; Mon, 16 Aug 2021 08:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 92D4B61B1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 58E8A401FA;
	Mon, 16 Aug 2021 08:21:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QKXmsYJ8SDyd; Mon, 16 Aug 2021 08:21:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 02D0A400F3;
	Mon, 16 Aug 2021 08:21:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB0B9C0010;
	Mon, 16 Aug 2021 08:21:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DB6A9C000E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 08:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B6024401D4
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 08:21:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yshNgsW_zixo for <iommu@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 08:21:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 220B7400F3
 for <iommu@lists.linux-foundation.org>; Mon, 16 Aug 2021 08:21:37 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B61661B2A;
 Mon, 16 Aug 2021 08:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629102096;
 bh=v18Ob//oOAIeQmu3aXKKRsWdxAHyy/T7LeoQ46bi2G8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Ubhjgvz4NQPP+8fF72SovDtWK7ukpc33jGB0RILwp86eu70aViqAfg1Ko8sY1NBlF
 8TLkQhYsCZ6OoaVMoRh2V/s1Cw3iCN0J6Fmjef45KOHC2/EmEaJXX4lPXJ84McPyRT
 q1kCMMxkdJNHAgXVtxwMn23Y5TUQ99cgnkVkZHwmgpZDU2iK/hnXqtNq49KNme+x1Y
 6OITEA0cw89WzV8X6XfHDNRoDcL1Uox6HsBhHismMEBLAYozj/LgDL0/t0b5b/xyFM
 IncMnbZYFKY4R6PvScxotv4gCAc5FiCyAUb/kP/EtsTCxgN8Fq0nurgmfT/8togwVS
 BegHYWgJa2g3A==
Date: Mon, 16 Aug 2021 09:21:27 +0100
From: Will Deacon <will@kernel.org>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/4] iommu/arm-smmu-v3: Use command queue batching
 helpers to improve performance
Message-ID: <20210816082126.GA11011@willie-the-truck>
References: <20210811114852.2429-1-thunder.leizhen@huawei.com>
 <20210811114852.2429-2-thunder.leizhen@huawei.com>
 <81258eb7-eb73-8a32-0983-3487daba1167@arm.com>
 <4e741216-d6e7-c40c-f257-242cd2fea302@huawei.com>
 <5482d2e5-24db-6139-a8a8-74be1282e2ec@huawei.com>
 <52204403-f69a-d2b9-9365-7553e87d1298@huawei.com>
 <a3cdd5df-c028-5484-ce99-928a689d341a@huawei.com>
 <e8b71423-e827-f141-1203-00aca2e70834@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e8b71423-e827-f141-1203-00aca2e70834@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, iommu <iommu@lists.linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Mon, Aug 16, 2021 at 03:47:58PM +0800, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/8/16 15:24, John Garry wrote:
> >> In addition, I find that function arm_smmu_cmdq_build_cmd() can also be optimized
> >> slightly, three useless instructions can be reduced.
> > 
> > I think that you could optimise further by pre-building commonly used commands.
> > 
> > For example, CMD_SYNC without MSI polling is always the same. And then only different in 1 field for MSI polling.
> > 
> > But you need to check if the performance gain is worth the change.
> 
> Good advice. I can give it a try.

Please send it as a new patch on top. I've queued the old one and sent
it to Joerg. Since this is just further cleanup, it can be done separately.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
