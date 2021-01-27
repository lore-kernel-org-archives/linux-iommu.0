Return-Path: <SRS0=KfvE=G6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8C9C433DB
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 09:24:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9FA02075B
	for <iommu@archiver.kernel.org>; Wed, 27 Jan 2021 09:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9FA02075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4017E857EB;
	Wed, 27 Jan 2021 09:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-iW3RDwm8HF; Wed, 27 Jan 2021 09:24:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 1CCEB86094;
	Wed, 27 Jan 2021 09:24:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EDCF8C08A1;
	Wed, 27 Jan 2021 09:24:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0FC17C013A
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 09:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F2BB3850DC
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 09:23:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aYl8vG0UZOK5 for <iommu@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 09:23:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 13DC98508E
 for <iommu@lists.linux-foundation.org>; Wed, 27 Jan 2021 09:23:58 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 212C420757;
 Wed, 27 Jan 2021 09:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1611739437;
 bh=bTJkY6o3gofoKbQ/JBPmgqJaeBCAHt8xrjpL7auhkvE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gE4XDtgBKYBGau3hX4YAe2kzDJSGrGdhPJ2JLrvrHekSuKwMzCmohHGdywaU8lZAJ
 kF3sK9p9AhsStR9TuHHQnZqzQWQolyg/rZW9Om6iotLqDPJYUsPGHasV2M3KyWV6DC
 nedlhGKqB7ggYrlcqQgpHtmPhqu2iXk0I1toi3NYtk672+IwSxLPJNEfSee2wSu8uD
 XKZKK7g7VTOXlI2oZctkLMTtggT3jcfnbQ5GVgssSWhmpKBzBchmWzYiV4nAVpxP+w
 KELYkUyfop2el2lVaE+PrRM1fAXb26APSyBoyeGcpraF8pPNaEacrthol+vRodO4Li
 voCiLtYqvNUdg==
Date: Wed, 27 Jan 2021 09:23:52 +0000
From: Will Deacon <will@kernel.org>
To: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Subject: Re: [PATCH 1/1] iommu/arm-smmu-v3: Use DEFINE_RES_MEM() to simplify
 code
Message-ID: <20210127092352.GA31790@willie-the-truck>
References: <20210122131448.1167-1-thunder.leizhen@huawei.com>
 <7f0b488d-f9b2-92b8-5914-2cef76b4d398@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7f0b488d-f9b2-92b8-5914-2cef76b4d398@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Wed, Jan 27, 2021 at 10:05:50AM +0800, Leizhen (ThunderTown) wrote:
> I've sent another set of patches. https://lkml.org/lkml/2021/1/26/1065
> If those patches are acceptable, then this one should be ignored.

I've already queued this one, so if you want me to drop it then you need to
send me a revert.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
