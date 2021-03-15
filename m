Return-Path: <SRS0=3mOG=IN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2043C433DB
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 03:17:50 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 457B264E6B
	for <iommu@archiver.kernel.org>; Mon, 15 Mar 2021 03:17:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 457B264E6B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E8C6E82CCA;
	Mon, 15 Mar 2021 03:17:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nw17sil3RMzq; Mon, 15 Mar 2021 03:17:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id D442882CCB;
	Mon, 15 Mar 2021 03:17:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 98995C000B;
	Mon, 15 Mar 2021 03:17:48 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 179C5C0001
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 03:17:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED54842FBC
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 03:17:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wdRmDhmFp76w for <iommu@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 03:17:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com
 [IPv6:2607:f8b0:4864:20::102b])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7B4F342FB5
 for <iommu@lists.linux-foundation.org>; Mon, 15 Mar 2021 03:17:46 +0000 (UTC)
Received: by mail-pj1-x102b.google.com with SMTP id
 mz6-20020a17090b3786b02900c16cb41d63so13969815pjb.2
 for <iommu@lists.linux-foundation.org>; Sun, 14 Mar 2021 20:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=A3oSUi/UHyvODn2iAEgaYMBdI8ZfE1MGKpYHvzVlBD8=;
 b=Mcz2Kz/8NugpP2eOCFKYqqihaLdnfTlrIToa2jAfUAFtK8nF+8b5+HMC0iZWV7WwH9
 /gxJ460YRfAVfGqYFc+Cy8cMBcaQNN5n3Olq2FT95PiriNijtQPNgWARGlZQssZ/MvOA
 dI8d45hy7m5c/ryJv6ydeStBb9t9tjMczP0qgqFsuNMn0oBSUYk+EvQrJfvXQ1abJkdD
 D6f3SD25UB8Qqw6rzjgAmmdwxDCzXf/tn+1qCE2A109GgnOGnMgeG40JMkkLE7s56ywi
 pAmNRIYxEYIQ9D4DCKoaTBzNxhmjTg8F3iOkXfb3fP1Sq2Ka4AVhUqaKNUpkfeXX7TXU
 1kmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=A3oSUi/UHyvODn2iAEgaYMBdI8ZfE1MGKpYHvzVlBD8=;
 b=sMXmXxoGsy2zgN5dYNLTO/3x5zKF/FcV4Z3KqxdzQACddbxG7CThzlXqw8OqRyG09y
 xbo88YV9eoLWum0uyaC199OLINCHf/efHD7MwsX/j1n56VAul5JOZT25mRDRO1/hqmqA
 wQ3RE/g8Nt7wm1y86HndguLkBp/zHs7PCVpUnbJIKipPTahd7O/76QY0JbE3N2rgr1kI
 QBstw21bPGjR2IFLUT4d8blCDBYtn4Sa54coX2chCf0FYJgk8cgv6dlJlqcNl2QKxfzC
 Q1b7dmuzCtFDQchD8Mgrjhs8ERVWmhxusMcwTuTZzL7BRXvdBJdBNjalbJuCsTJEjEzV
 cYQQ==
X-Gm-Message-State: AOAM530jrwWmon6VKlIjDnyPL+bcuYTFfggzKy9hBJ2tzxox4PA8hbbI
 xwhgisXRnt+MRshbn4IY2kc=
X-Google-Smtp-Source: ABdhPJw8csEJ+/wV3Fc9v2//Qr1oJRddD+wFWsM0q5sBkVsiD35ZB1Yido7lA7a3WSDEcn6yYgIKZA==
X-Received: by 2002:a17:90a:ea96:: with SMTP id
 h22mr10351284pjz.24.1615778265901; 
 Sun, 14 Mar 2021 20:17:45 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id k15sm11855229pgt.23.2021.03.14.20.17.44
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 14 Mar 2021 20:17:45 -0700 (PDT)
Date: Sun, 14 Mar 2021 20:15:31 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v3] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20210315031530.GA15245@Asurada-Nvidia>
References: <20210314080653.29374-1-nicoleotsuka@gmail.com>
 <e1d3eef7-3d7e-b26d-79d2-f87969ac11f8@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e1d3eef7-3d7e-b26d-79d2-f87969ac11f8@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 jonathanh@nvidia.com, thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 will@kernel.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

T24gU3VuLCBNYXIgMTQsIDIwMjEgYXQgMDY6MDg6MDBQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDE0LjAzLjIwMjEgMTE6MDYsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
Kwlmb3IgKHBkX2luZGV4ID0gMDsgcGRfaW5kZXggPCBTTU1VX05VTV9QREU7IHBkX2luZGV4Kysp
IHsKPiA+ICsJCXN0cnVjdCBwYWdlICpwdF9wYWdlOwo+ID4gKwkJdTMyICphZGRyOwo+ID4gKwkJ
aW50IGk7Cj4gCj4gdW5zaWduZWQgaW50Cj4gCj4gYW5kIHRoZW4gcHJpbnRmIHNwZWNpZmllcnMg
YWxzbyBzaG91bGQgYmUgJXUKCkZpeGluZyBpdCwgdXNpbmcgeW91ciBwcmV2aW91cyBjaGFuZ2Vz
IHRvby4gVGhhbmtzIQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
