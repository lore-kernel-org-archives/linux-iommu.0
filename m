Return-Path: <SRS0=c0M2=2J=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE333C43603
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 20:10:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A10E2467E
	for <iommu@archiver.kernel.org>; Thu, 19 Dec 2019 20:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="bp22UgZa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A10E2467E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 717348808C;
	Thu, 19 Dec 2019 20:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y70aRCQnncXL; Thu, 19 Dec 2019 20:10:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 89DFA86914;
	Thu, 19 Dec 2019 20:10:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BEB6C1AE8;
	Thu, 19 Dec 2019 20:10:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C8E4C077D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 20:10:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id EFD2F88763
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 20:10:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SBTKOJEa-tp5 for <iommu@lists.linux-foundation.org>;
 Thu, 19 Dec 2019 20:10:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail25.static.mailgun.info (mail25.static.mailgun.info
 [104.130.122.25])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 704BB8875D
 for <iommu@lists.linux-foundation.org>; Thu, 19 Dec 2019 20:10:47 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org;
 q=dns/txt; 
 s=smtp; t=1576786247; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: To: From: Date: Sender;
 bh=/5veci3IX8iV9Lr7OinmX1GSclV5/3Uya8rEs4CH8nA=;
 b=bp22UgZaER7TTqUPXf0BoAfh4ZnDDFDQhTnnqn65R3YuQI4TWT4gjv254XIe0/7zRH+5UdbZ
 DPXFCJHFdhP9+nhoV5pMyAyajLoRcCNJMwT3SHYRXKkGP7m2GJ6Sn9czA+wyGNHu7DKzDWc7
 FoE0Zb40TSX/eeaobxZTC7lQIzs=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3NDkwMCIsICJpb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZyIsICJiZTllNGEiXQ==
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5dfbd944.7f0b92678298-smtp-out-n03;
 Thu, 19 Dec 2019 20:10:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
 id ABEDEC447A4; Thu, 19 Dec 2019 20:10:44 +0000 (UTC)
Received: from jcrouse1-lnx.qualcomm.com (i-global254.qualcomm.com
 [199.106.103.254])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: jcrouse)
 by smtp.codeaurora.org (Postfix) with ESMTPSA id 5878AC447A0;
 Thu, 19 Dec 2019 20:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5878AC447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org;
 spf=none smtp.mailfrom=jcrouse@codeaurora.org
Date: Thu, 19 Dec 2019 13:10:41 -0700
From: Jordan Crouse <jcrouse@codeaurora.org>
To: Sharat Masetty <smasetty@codeaurora.org>,
 freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org, saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 5/5] drm/msm/a6xx: Add support for using system cache(LLC)
Message-ID: <20191219201041.GB23673@jcrouse1-lnx.qualcomm.com>
Mail-Followup-To: Sharat Masetty <smasetty@codeaurora.org>,
 freedreno@lists.freedesktop.org, dri-devel@freedesktop.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
 iommu@lists.linux-foundation.org, saiprakash.ranjan@codeaurora.org
References: <1576761286-20451-1-git-send-email-smasetty@codeaurora.org>
 <1576761286-20451-6-git-send-email-smasetty@codeaurora.org>
 <20191219195814.GA23673@jcrouse1-lnx.qualcomm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20191219195814.GA23673@jcrouse1-lnx.qualcomm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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

On Thu, Dec 19, 2019 at 12:58:15PM -0700, Jordan Crouse wrote:
> On Thu, Dec 19, 2019 at 06:44:46PM +0530, Sharat Masetty wrote:


<snip>

> > +
> > +	/*
> > +	 * CNTL1 is used to specify SCID for (CP, TP, VFD, CCU and UBWC
> > +	 * FLAG cache) GPU blocks. This value will be passed along with
> > +	 * the address for any memory transaction from GPU to identify
> > +	 * the sub-cache for that transaction.
> > +	 */
> > +	if (!IS_ERR(llc->gpu_llc_slice)) {
> > +		u32 gpu_scid = llcc_get_slice_id(llc->gpu_llc_slice);
> > +		int i;
> > +
> > +		for (i = 0; i < A6XX_LLC_NUM_GPU_SCIDS; i++)
> > +			llc->cntl1_regval |=
> > +				gpu_scid << (A6XX_GPU_LLC_SCID_NUM_BITS * i);
> 
> As above, i'm not sure a loop is better than just:
> 
> gpu_scid &= 0x1f;
> 
> llc->cntl1_regval = (gpu_scid << 0) || (gpu_scid << 5) | (gpu_scid << 10)
>  | (gpu_scid << 15) | (gpu_scid << 20);
> 
> And I'm not even sure we need do this math here in the first place.

One more question - can you get a valid slice id before activation?

<snip>

Jordan

-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
