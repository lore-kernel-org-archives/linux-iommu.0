Return-Path: <SRS0=32yV=6V=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33C09C35280
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 21:36:25 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEB96208DB
	for <iommu@archiver.kernel.org>; Thu,  7 May 2020 21:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EvyLgigN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEB96208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A25548739A;
	Thu,  7 May 2020 21:36:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dd4Jjw6Mng8L; Thu,  7 May 2020 21:36:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EF0FC85F69;
	Thu,  7 May 2020 21:36:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4191C0859;
	Thu,  7 May 2020 21:36:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 00332C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 21:36:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BAA8B20553
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 21:36:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dLnLoc4vz99b for <iommu@lists.linux-foundation.org>;
 Thu,  7 May 2020 21:36:21 +0000 (UTC)
X-Greylist: delayed 00:15:09 by SQLgrey-1.7.6
Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com
 [209.85.167.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 6EA922000B
 for <iommu@lists.linux-foundation.org>; Thu,  7 May 2020 21:36:21 +0000 (UTC)
Received: by mail-oi1-f193.google.com with SMTP id c12so5583051oic.1
 for <iommu@lists.linux-foundation.org>; Thu, 07 May 2020 14:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:content-transfer-encoding:in-reply-to:references
 :subject:from:cc:to:date:message-id:user-agent;
 bh=ioAtKKBLetMrNC3UOrZBDpCms01n9tKhgmw2P4KuQ10=;
 b=EvyLgigNsQCXtN+ZrgfW3obNeN7n95kvB+iKsA3+ZKnx6Pg5GXwuwrpAimKciweQLh
 A5IVBx9MVFabDi+Q4FiPn1IL+Ut97gCeTeb7mX2JJGN/XYRuTQAwLpP2rSFctxdoyafo
 dTtwQ79hSAA/WHsbFnshcKXq7Ma1fctt8eopE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:content-transfer-encoding
 :in-reply-to:references:subject:from:cc:to:date:message-id
 :user-agent;
 bh=ioAtKKBLetMrNC3UOrZBDpCms01n9tKhgmw2P4KuQ10=;
 b=O3qv4urObH+dIAa59bCwac12SyYjsAbOJSDEf36hMHSD47P8/rpumN8dd8MRP/AWQr
 CHfS+cy74rrTvs54sJxoJAt+r1T9iOS+uk4vlr1oAIwF4obFzwKxQujeQdpIhhQDg1KE
 Cwfqz9srqH5mwDqdTjIC9FAtgFweXANnXSMb5N7h08fwEf4bw6RjSrKiXW1opfxNC8Wg
 o9FGWojbdNz5ZYXgzzmCyga8paVqgo8Z2aa6MxqqM3uJ/Q+TBlAs3Bl01qXQ0syXoh8V
 5Uz1YDKnHGilngquZPppVwoaf4oshL43bxrX/qaxdyinQEj5KTUiUG2R/tKRkcUMvIB1
 VLsw==
X-Gm-Message-State: AGi0PuZRXBb1gqZUrclytsavbDZoGEHQksYxmpPcddG9eQSvNRVXWLA1
 /NzWurr0DvYk2OVR0Ec8szzCJY3NfL8=
X-Google-Smtp-Source: APiQypJ3ry9ekB/Mu6A+agxgYdfo7bbCE87C+rrfPRAkcpuV1AuLxv17o9r4CKcuSidKzhyfOYnUbA==
X-Received: by 2002:a17:90a:fd94:: with SMTP id
 cx20mr2284622pjb.157.1588886079220; 
 Thu, 07 May 2020 14:14:39 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
 by smtp.gmail.com with ESMTPSA id x63sm5873453pfc.56.2020.05.07.14.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 14:14:38 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20200507192157.6831-1-sibis@codeaurora.org>
References: <20200507192157.6831-1-sibis@codeaurora.org>
Subject: Re: [PATCH v5] iommu/arm-smmu-qcom: Request direct mapping for modem
 device
From: Stephen Boyd <swboyd@chromium.org>
To: Sibi Sankar <sibis@codeaurora.org>, joro@8bytes.org, robin.murphy@arm.com,
 will@kernel.org
Date: Thu, 07 May 2020 14:14:37 -0700
Message-ID: <158888607765.26370.18078298627976225073@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Cc: linux-arm-msm@vger.kernel.org, dianders@chromium.org, evgreen@chromium.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 mka@chromium.org, Sibi Sankar <sibis@codeaurora.org>,
 bjorn.andersson@linaro.org, linux-arm-kernel@lists.infradead.org
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

Quoting Sibi Sankar (2020-05-07 12:21:57)
> The modem remote processor has two modes of access to the DDR, a direct
> mode and through a SMMU which requires direct mapping. The configuration
> of the modem SIDs is handled in TrustZone.

Is it "The configuration of the modem SIDs is typically handled by
code running in the ARM CPU's secure mode, i.e. secure EL1"? And is that
even true? I though it was programmed by EL2.

> On platforms where TrustZone

TrustZone is always there.

> is absent this needs to be explicitly done from kernel. Add compatibles
> for modem to opt in for direct mapping on such platforms.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>

Is Sai the author? Or does this need a co-developed-by tag?

> Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
> ---
> 
> V5
>  * Reword commit message and drop unnecessary details

I don't see any improvement! Probably because I don't understand _why_
the modem needs a direct mapping. The commit text basically says "we
need to do it because it isn't done in secure world sometimes". This is
probably wrong what I wrote below, but I'd like to clarify to confirm my
understanding. Maybe the commit text should say:

The modem remote processor has two access paths to DDR. One path is
directly connected to DDR and another path goes through an SMMU. The
SMMU path is configured to be a direct mapping because it's used by
various peripherals in the modem subsystem. Typically this direct
mapping is configured by programming modem SIDs into the SMMU when EL2
responds to a hyp call from the code that loads the modem binary in the
secure world.

In certain firmware configurations, especially when the kernel is
entered at EL2, we don't want secure mode to make hyp calls to program
the SMMU because the kernel is in full control of the SMMU. Let's add
compatibles here so that we can have the kernel program the SIDs for the
modem in these cases.
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
