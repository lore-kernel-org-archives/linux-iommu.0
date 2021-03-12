Return-Path: <SRS0=dgoC=IK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF354C433E0
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 01:11:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 725AC64F7E
	for <iommu@archiver.kernel.org>; Fri, 12 Mar 2021 01:11:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 725AC64F7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 31DAC4ECA1;
	Fri, 12 Mar 2021 01:11:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x_tSHh3MwY8i; Fri, 12 Mar 2021 01:11:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F294D4ED33;
	Fri, 12 Mar 2021 01:11:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BBC04C000A;
	Fri, 12 Mar 2021 01:11:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01DC1C0001
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 01:11:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C363147E1F
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 01:11:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6FVNWpsIUPNO for <iommu@lists.linux-foundation.org>;
 Fri, 12 Mar 2021 01:11:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com
 [IPv6:2607:f8b0:4864:20::102d])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 19C154ED37
 for <iommu@lists.linux-foundation.org>; Fri, 12 Mar 2021 01:11:49 +0000 (UTC)
Received: by mail-pj1-x102d.google.com with SMTP id
 q6-20020a17090a4306b02900c42a012202so10241691pjg.5
 for <iommu@lists.linux-foundation.org>; Thu, 11 Mar 2021 17:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=16+EGqIhvzNXbdawWsI24XgIQiUgZzzrwVqWt5tsI6Q=;
 b=k9/V8e9h7lxJGy3+MvDbuIN+ZYqSyUG2tRF5AcbhR75EaTsDgVFbTPeXzQFoCt5Y0z
 maWum4fpgZCnxzMCM1UnW6bV7Mc2dki6/0AEPh09DM69U4ozafluPUirqWTSkR3qG5ZL
 TSs0o2z4duN4aAcf3R0oLBDNGwGZ6IBeAhMoS8/4GEYwtyNOWYRgduR3Ucky7rCRJaQS
 Xd54+6SIcYHnOWuWSRZt5t6f4pxRxV0n12IFfwY3Or+u6tch+nNOSe8ZrKzL38zFBgs5
 F6esRhGL1FrhBS8hrao32eJDPriSrnDFQBn2dPFJML18s58L0JOwcbt0p9QzSH/54iOD
 y+PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=16+EGqIhvzNXbdawWsI24XgIQiUgZzzrwVqWt5tsI6Q=;
 b=nSUNWBGky05JfhJhYhZwJri4v5qP/N7hUQJ3gZvy9jlNtW2XDAawcAwSLJv4JWIJlr
 jPrcWqqM+wrmhE0Vw1weWNjKqg2ZYRF7ISRAjfgQbe0MwIapaCJ8vwhBgNae2Zbbjnoh
 5V0T3SsCC4A+X5m9ImvBmazJnNW8Zhrx2c5ADiv01q8Xg4qwF7kZPIs7qj5PTXEVtS3X
 +SQ7Fbe3YOxr6Qdezdml6HefZ8U64FnLDJtgxumyfu7nTqf1VAlWci9XCDaL9XAMbQWF
 bGmQqGPC3XiA8iS5uri1nVSVM+R4dFVXOwOPWujzGA+Hbwz/T24V76YhlByTB1WaMGA7
 hP6g==
X-Gm-Message-State: AOAM531SJNOcuzpYhi3tZ4w0iJrEysKJIX5UBHbwYFXhyQDj5SSfHSG0
 rPbvfdWJfx1dNz2C9QaYI2M=
X-Google-Smtp-Source: ABdhPJzra0SHtLriT5uJdvG596fUt/NZvuBX6OT9xr5DxY7UWyuTAm+swZOTYPYO+BHr8ri+MLVl2Q==
X-Received: by 2002:a17:90a:f82:: with SMTP id
 2mr11837097pjz.196.1615511508531; 
 Thu, 11 Mar 2021 17:11:48 -0800 (PST)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id y7sm268087pja.25.2021.03.11.17.11.47
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 11 Mar 2021 17:11:48 -0800 (PST)
Date: Thu, 11 Mar 2021 17:09:33 -0800
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2] iommu/tegra-smmu: Add pagetable mappings to debugfs
Message-ID: <20210312010932.GB29926@Asurada-Nvidia>
References: <20210310033614.16772-1-nicoleotsuka@gmail.com>
 <abcedfa6-fbad-b34d-fba1-d3a778fbf5b4@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abcedfa6-fbad-b34d-fba1-d3a778fbf5b4@gmail.com>
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

T24gVGh1LCBNYXIgMTEsIDIwMjEgYXQgMDU6MDQ6MDZQTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDEwLjAzLjIwMjEgMDY6MzYsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+IC4u
Lgo+ID4gK3N0YXRpYyBpbnQgdGVncmFfc21tdV9tYXBwaW5nc19zaG93KHN0cnVjdCBzZXFfZmls
ZSAqcywgdm9pZCAqZGF0YSkKPiA+ICt7Cj4gPiArCXN0cnVjdCB0ZWdyYV9zbW11X2dyb3VwX2Rl
YnVnICpncm91cF9kZWJ1ZyA9IHMtPnByaXZhdGU7Cj4gPiArCWNvbnN0IHN0cnVjdCB0ZWdyYV9z
bW11X3N3Z3JvdXAgKmdyb3VwOwo+ID4gKwlzdHJ1Y3QgdGVncmFfc21tdV9hcyAqYXM7Cj4gPiAr
CXN0cnVjdCB0ZWdyYV9zbW11ICpzbW11Owo+ID4gKwlpbnQgcGRfaW5kZXgsIHB0X2luZGV4Owo+
IAo+ID4gK0RFRklORV9TSE9XX0FUVFJJQlVURSh0ZWdyYV9zbW11X21hcHBpbmdzKTsKPiA+ICsK
PiA+ICBzdGF0aWMgdm9pZCB0ZWdyYV9zbW11X2RlYnVnZnNfaW5pdChzdHJ1Y3QgdGVncmFfc21t
dSAqc21tdSkKPiA+ICB7Cj4gPiArCWNvbnN0IHN0cnVjdCB0ZWdyYV9zbW11X3NvYyAqc29jID0g
c21tdS0+c29jOwo+ID4gKwlzdHJ1Y3QgdGVncmFfc21tdV9ncm91cF9kZWJ1ZyAqZ3JvdXBfZGVi
dWc7Cj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IHNtbXUtPmRldjsKPiA+ICsJc3RydWN0IGRl
bnRyeSAqZDsKPiA+ICsJaW50IGk7Cj4gCj4gWW91IHNob3VsZCB1c2UgdW5zaWduZWQgdHlwZXMg
Zm9yIGV2ZXJ5dGhpbmcgdGhhdCBpc24ndCBzaWduZWQuCgpPa2F5LiBXaWxsIGZpeC4gVGhhbmtz
IQpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwppb21tdSBt
YWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
