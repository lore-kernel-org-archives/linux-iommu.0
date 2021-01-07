Return-Path: <SRS0=iLvA=GK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12DEC433DB
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 14:39:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 439FC22EBF
	for <iommu@archiver.kernel.org>; Thu,  7 Jan 2021 14:39:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 439FC22EBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id F286A2746F;
	Thu,  7 Jan 2021 14:39:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ys4-yp02CJt6; Thu,  7 Jan 2021 14:39:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 1244D20133;
	Thu,  7 Jan 2021 14:39:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E9D64C088B;
	Thu,  7 Jan 2021 14:39:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 93D7BC013A
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:39:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 796AF873BF
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:39:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hwPhfM6JAvex for <iommu@lists.linux-foundation.org>;
 Thu,  7 Jan 2021 14:39:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A5B22873B2
 for <iommu@lists.linux-foundation.org>; Thu,  7 Jan 2021 14:39:08 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 92646217A0;
 Thu,  7 Jan 2021 14:39:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1610030348;
 bh=YWEcxhex87qRhDcmUQgovNSsPvhG+kKequUOj5ZrPco=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FIC+a1NcKdmkefH0TZ04wEJSA0N0X+XPEmffWdWFyJ65aslvzDaOubPJtqvdTEgTA
 mL66YFSKt6oTvwq1HMMco+2c7mpiBV5XyQ+iKVcjd+GHlb2+97YSAW44RP+P9J76gP
 ilI3tcRIrJodIWbSSRxBuf2TgixmFufEbqMshUbeGi/OOtv9krfjQX26q3+vEMe+dp
 kIGxU6/4n4KJhNIhViwcd58ScrT7JRpZGt4/gbON+oEOx1gbk3FJzFv9tv7ML9d+WZ
 KPska6pUUN8AnT8bNn0it3DUNiHag8bLAITlg4bKsnhQRHEgamgzixOM+ek6pKctOC
 WI6vvUUgst9CQ==
Date: Thu, 7 Jan 2021 14:39:03 +0000
From: Will Deacon <will@kernel.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v4 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info
Message-ID: <20210107143903.GA3413@willie-the-truck>
References: <1609949037-25291-1-git-send-email-yi.l.liu@intel.com>
 <1609949037-25291-3-git-send-email-yi.l.liu@intel.com>
 <20210107134906.GA3043@willie-the-truck>
 <591fa06b-8db1-57a5-8c61-d6ba28bc8c04@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <591fa06b-8db1-57a5-8c61-d6ba28bc8c04@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: yi.y.sun@intel.com, kevin.tian@intel.com, ashok.raj@intel.com,
 jun.j.tian@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, dan.carpenter@oracle.com
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

On Thu, Jan 07, 2021 at 10:16:57PM +0800, Lu Baolu wrote:
> On 2021/1/7 21:49, Will Deacon wrote:
> > On Thu, Jan 07, 2021 at 12:03:56AM +0800, Liu Yi L wrote:
> > > In the existing code, loop all devices attached to a domain does not
> > > include sub-devices attached via iommu_aux_attach_device().
> > > 
> > > This was found by when I'm working on the below patch, There is no
> > > device in the domain->devices list, thus unable to get the cap and
> > > ecap of iommu unit. But this domain actually has subdevice which is
> > > attached via aux-manner. But it is tracked by domain. This patch is
> > > going to fix it.
> > > 
> > > https://lore.kernel.org/kvm/1599734733-6431-17-git-send-email-yi.l.liu@intel.com/
> > > 
> > > And this fix goes beyond the patch above, such sub-device tracking is
> > > necessary for other cases. For example, flushing device_iotlb for a
> > > domain which has sub-devices attached by auxiliary manner.
> > 
> > Sorry, but I'm having a really hard time understanding what this patch is
> > doing based on this commit message. Baolu -- do you think you could reword
> > it for me please? No need to resend the patch.
> 
> iommu/vt-d: Fix general protection fault in aux_detach_device()

[...]

Thanks! I'll push this out shortly.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
