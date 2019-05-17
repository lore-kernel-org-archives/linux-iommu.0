Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E8EC04E87
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 22:07:04 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40D75216FD
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 22:07:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y9fdFpl3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40D75216FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 02111E2C;
	Fri, 17 May 2019 22:07:04 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 6AFC2DB9
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 22:07:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0AEF4710
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 22:07:01 +0000 (UTC)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
	[209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id A804B21734
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 22:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1558130821;
	bh=NGfDVpnHGlZSPBv3BpoihAF+0N7E7o+m14ZovnpkobE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=y9fdFpl39fMid+8MsAA/hPpFb3TrE6k7jLGR+qBODvjBpasdPNATrAFSnanBPYEuo
	KtPp2TC60I+dC2MynZazihAVFCl0jWkxQa8eV2Y4QOiEO/fEEvbGhmecLADiaLmnbA
	1r+a7Fd/E/FeD0aKgq2gMx7ncK4i8B2OPhhCrMMs=
Received: by mail-qt1-f170.google.com with SMTP id t1so9743247qtc.12
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 15:07:01 -0700 (PDT)
X-Gm-Message-State: APjAAAU7Zca/7TbfEfw2TBT8/un21wkMsL+VlcDPwRc1Ql0ZsQrbSc7F
	YOfV0TD4MMoEx5Q/ywEDB8YTszjcikCalX3NVA==
X-Google-Smtp-Source: APXvYqzgnPSjbNZB21jfdHyrVRvTQpjTFduXMTCC2dRcGxkUBTV0K1qQ8CT5M1gXcRQgkiXQx+OFoK0kRL1cf4DpnAo=
X-Received: by 2002:ac8:2d48:: with SMTP id o8mr51145213qta.136.1558130820928; 
	Fri, 17 May 2019 15:07:00 -0700 (PDT)
MIME-Version: 1.0
References: <1558118857-16912-1-git-send-email-isaacm@codeaurora.org>
	<1558118857-16912-2-git-send-email-isaacm@codeaurora.org>
In-Reply-To: <1558118857-16912-2-git-send-email-isaacm@codeaurora.org>
From: Rob Herring <robh+dt@kernel.org>
Date: Fri, 17 May 2019 17:06:48 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKcZaQCZuodCiaTKV1ZyQQcufL4P4jpcDcKCDwR0B+6EA@mail.gmail.com>
Message-ID: <CAL_JsqKcZaQCZuodCiaTKV1ZyQQcufL4P4jpcDcKCDwR0B+6EA@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/4] of: Export of_phandle_iterator_args() to modules
To: "Isaac J. Manjarres" <isaacm@codeaurora.org>
Cc: devicetree@vger.kernel.org, Android Kernel Team <kernel-team@android.com>,
	linux-pci@vger.kernel.org, Will Deacon <will.deacon@arm.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Pratik Patel <pratikp@codeaurora.org>,
	Linux IOMMU <iommu@lists.linux-foundation.org>,
	lmark@codeaurora.org, Bjorn Helgaas <bhelgaas@google.com>,
	Frank Rowand <frowand.list@gmail.com>,
	"moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
	<linux-arm-kernel@lists.infradead.org>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

On Fri, May 17, 2019 at 1:48 PM Isaac J. Manjarres
<isaacm@codeaurora.org> wrote:
>
> Kernel modules may want to use of_phandle_iterator_args(),
> so export it.
>
> Signed-off-by: Isaac J. Manjarres <isaacm@codeaurora.org>
> ---
>  drivers/of/base.c | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
