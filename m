Return-Path: <SRS0=Fh/M=IX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0035C433DB
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 15:05:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB4761A12
	for <iommu@archiver.kernel.org>; Thu, 25 Mar 2021 15:05:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB4761A12
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 094B484A48;
	Thu, 25 Mar 2021 15:05:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M19ce7I2DQez; Thu, 25 Mar 2021 15:05:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id B9F1284A47;
	Thu, 25 Mar 2021 15:05:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A385DC000E;
	Thu, 25 Mar 2021 15:05:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 35698C000A
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:05:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2393F84A66
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:05:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8llrHm-rmiAf for <iommu@lists.linux-foundation.org>;
 Thu, 25 Mar 2021 15:05:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 74B4984A64
 for <iommu@lists.linux-foundation.org>; Thu, 25 Mar 2021 15:05:12 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3605661A10;
 Thu, 25 Mar 2021 15:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1616684712;
 bh=n14K+ZB1lA7IMk1Xs/vk0MsKfm+3TbQdanrbmyKqpNM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=FHwTNUwG1zuMokZAgMv+sMZgUup0IwNDeUPoK80BWyBn6qBaK8/0r77noT9b22CO1
 +QgJ4wRl9+tw0cyi4qCWLyJF/8jj4VXdjJWlroSsAGz5sTz+4hqG+gID7Zopt9ijcM
 Nq1V2NLzcjRvgMF5It9za/kecF7ySF4YGllMEHjAMZxuFr+e7443N9/wcoh72w8n1H
 PrLPze1Dj5JEvhLsmuOYyVYE0/fcFm79OMJ3h9TeiLoJt3KK3tUPr1YWoU9xfO44D2
 kv94bWZc/lZUuS4UIQhWJQb6A5Bg3xT14NfpujrO4I3P4si32tHsCWOSAtyyx7ZcT0
 P3uFFMlej36iQ==
Date: Thu, 25 Mar 2021 15:05:07 +0000
From: Will Deacon <will@kernel.org>
To: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
Message-ID: <20210325150506.GD15172@willie-the-truck>
References: <YDlIrjkfv16o4Nu3@builder.lan>
 <20210227135321.420-1-saiprakash.ranjan@codeaurora.org>
 <YEqn1SjsGgK0V8K4@builder.lan>
 <8cfaed1915ad6dd0c34ac7eb2391b410@codeaurora.org>
 <727fa9fe2e644f88ba35c2877d71788e@codeaurora.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <727fa9fe2e644f88ba35c2877d71788e@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 jcrouse@codeaurora.org, akhilpo@codeaurora.org,
 iommu@lists.linux-foundation.org, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Thu, Mar 25, 2021 at 01:10:12PM +0530, Sai Prakash Ranjan wrote:
> On 2021-03-15 00:31, Sai Prakash Ranjan wrote:
> > On 2021-03-12 04:59, Bjorn Andersson wrote:
> > > On Sat 27 Feb 07:53 CST 2021, Sai Prakash Ranjan wrote:
> > > > On 2021-02-27 00:44, Bjorn Andersson wrote:
> > > > > On Fri 26 Feb 12:23 CST 2021, Rob Clark wrote:
> > > > >
> > > > >
> > > > > The current logic picks one of:
> > > > > 1) is the compatible mentioned in qcom_smmu_impl_of_match[]
> > > > > 2) is the compatible an adreno
> > > > > 3) no quirks needed
> > > > >
> > > > > The change flips the order of these, so the only way I can see this
> > > > > change affecting things is if we expected a match on #2, but we got one
> > > > > on #1.
> > > > >
> > > > > Which implies that the instance that we want to act according to the
> > > > > adreno impl was listed in qcom_smmu_impl_of_match[] - which either is
> > > > > wrong, or there's a single instance that needs both behaviors.
> > > > >
> > > > > (And I believe Jordan's answer confirms the latter - there's a single
> > > > > SMMU instance that needs all them quirks at once)
> > > > >
> > > > 
> > > > Let me go through the problem statement in case my commit
> > > > message wasn't
> > > > clear. There are two SMMUs (APSS and GPU) on SC7280 and both are
> > > > SMMU500
> > > > (ARM SMMU IP).
> > > > 
> > > > APSS SMMU compatible - ("qcom,sc7280-smmu-500", "arm,mmu-500")
> > > > GPU SMMU compatible - ("qcom,sc7280-smmu-500",
> > > > "qcom,adreno-smmu", "arm,mmu-500")
> > > > 
> > > > Now if we take SC7180 as an example, GPU SMMU was QSMMU(QCOM SMMU IP)
> > > > and APSS SMMU was SMMU500(ARM SMMU IP).
> > > > 
> > > > APSS SMMU compatible - ("qcom,sc7180-smmu-500", "arm,mmu-500")
> > > > GPU SMMU compatible - ("qcom,sc7180-smmu-v2",
> > > > "qcom,adreno-smmu", "qcom,smmu-v2")
> > > > 
> > > > Current code sequence without this patch,
> > > > 
> > > > if (of_match_node(qcom_smmu_impl_of_match, np))
> > > >                  return qcom_smmu_create(smmu, &qcom_smmu_impl);
> > > > 
> > > > if (of_device_is_compatible(np, "qcom,adreno-smmu"))
> > > >         return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
> > > > 
> > > > Now if we look at the compatible for SC7180, there is no problem
> > > > because
> > > > the APSS SMMU will match the one in qcom_smmu_impl_of_match[]
> > > > and GPU SMMU
> > > > will match "qcom,adreno-smmu" because the compatible strings are
> > > > different.
> > > > But for SC7280, both the APSS SMMU and GPU SMMU
> > > > compatible("qcom,sc7280-smmu-500")
> > > > are same. So GPU SMMU will match with the one in
> > > > qcom_smmu_impl_of_match[]
> > > > i.e.., "qcom,sc7280-smmu-500" which functionally doesn't cause
> > > > any problem
> > > > but we will miss settings for split pagetables which are part of
> > > > GPU SMMU
> > > > specific implementation.
> > > > 
> > > > We can avoid this with yet another new compatible for GPU SMMU
> > > > something like
> > > > "qcom,sc7280-adreno-smmu-500" but since we can handle this
> > > > easily in the
> > > > driver and since the IPs are same, meaning if there was a
> > > > hardware quirk
> > > > required, then we would need to apply to both of them and would
> > > > this additional
> > > > compatible be of any help?
> > > > 
> > > 
> > > No, I think you're doing the right thing of having them both. I just
> > > didn't remember us doing that.
> > > 
> > > > Coming to the part of quirks now, you are right saying both
> > > > SMMUs will need
> > > > to have the same quirks in SC7280 and similar others where both
> > > > are based on
> > > > same IPs but those should probably be *hardware quirks* and if
> > > > they are
> > > > software based like the S2CR quirk depending on the firmware,
> > > > then it might
> > > > not be applicable to both. In case if it is applicable, then as
> > > > Jordan mentioned,
> > > > we can add the same quirks in GPU SMMU implementation.
> > > > 
> > > 
> > > I do suspect that at some point (probably sooner than later) we'd have
> > > to support both inheriting of stream from the bootloader and the
> > > Adreno
> > > "quirks" in the same instance.
> > > 
> > > But for now this is okay to me.
> > > 
> > 
> > Sure, let me know if you or anyone face any issues without it and I will
> > add it. I will resend this series with the dt-bindings patch for sc7280
> > smmu
> > which wasn't cc'd to smmu folks by mistake.
> > 
> 
> I think there is consensus on this series. I can resend if required but it
> still applies cleanly, let me know if you have any comments?

Please resend with the bindings patch, and I'd like Bjorn's Ack as well.

Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
