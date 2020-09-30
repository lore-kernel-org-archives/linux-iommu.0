Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D08C4727F
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:39:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7438520706
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBLomMXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7438520706
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 29DE385CB8;
	Wed, 30 Sep 2020 05:39:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LQBwcV0drhaV; Wed, 30 Sep 2020 05:39:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id CE3B585C94;
	Wed, 30 Sep 2020 05:39:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6F78C0889;
	Wed, 30 Sep 2020 05:39:57 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A17DEC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9595385CB8
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:39:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VcNMWqdbQ8fp for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:39:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com
 [209.85.216.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 246A085C94
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:39:56 +0000 (UTC)
Received: by mail-pj1-f65.google.com with SMTP id l18so245053pjz.1
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=Sfmy7ZZk8UYvhy6RI4/Gpi21fRi4lNKb0jBd0kAjjJg=;
 b=nBLomMXfzt25vf2Sp3AqO31imNEOWbZcgTQPPOCYTE8aOFY3RPAHFBcs2UwqO3CJzD
 47WXkMWRUsgzBxptzv0S/eO2EoljUV58BKgQ241e/Ey66Zf4bh9VUBy8TchAtu8UMcfh
 tmUkh6/qvB436J9VJBOolQu89lFV7v1BB3kZ0pjbiV/2NN4MRAl45WaaBygyCdNt7zxD
 xzafK1VUznndfBPTehWmGfPoR6WVZiZVoKz/uw9VwNQYsQybSvnavFU6gLvWbDfImHC8
 D+mWmzNOFwaF9QvHktr+deKI9kFNYy9JlmrR7p2TAf7ft60cXbMEwtK0762FndRKX7zC
 bqFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=Sfmy7ZZk8UYvhy6RI4/Gpi21fRi4lNKb0jBd0kAjjJg=;
 b=HBjXcRm56eblQaRkPBQ24pHbLonHQFfeA4l8QMBt5sjS8ZZ6xQE+D4AS+8zQs28geG
 TQrqqTcEOYxO6fp1L2bgrj4t33Rx0lb0bZDvV0V6cgX+CMgeRagEWtVsJ1D9KU84dnqP
 HXSgXuMKV1hDw+Pn3904AXDHwzITJK23uHbsFchyyRNcVhMYnH8zsxBpAmdVxtsG2nRs
 WyUwHE+3rqqhhAB2d9Ll5P2qcq0L7djNI9ELjM/GY+/UoMvO5NHYMvA1pOxzEM6e7MAH
 h4rT1EX1x70LvvojccuIT4+uMQOZviwifQGJBjHme6gJbg3vH2Qla5OaYayr+rsGskyB
 vREQ==
X-Gm-Message-State: AOAM532zsWZrbNjlBa/7ViERRbuuOcYUDScOfIfhzPVKI5bIT8UDpHj9
 4RbuTuQmcwUQBAtTnMrvR94=
X-Google-Smtp-Source: ABdhPJyyhjRdMS6ldpAFpjKqaSpdHHXAmWHoyYuuQf3hOBabEmtv2ZkvYbkAJONPEBqd4PWKJ+HmiQ==
X-Received: by 2002:a17:90a:1f43:: with SMTP id
 y3mr1055313pjy.28.1601444395688; 
 Tue, 29 Sep 2020 22:39:55 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id o11sm687625pgq.36.2020.09.29.22.39.55
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Sep 2020 22:39:55 -0700 (PDT)
Date: Tue, 29 Sep 2020 22:34:25 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 3/3] iommu/tegra-smmu: Add PCI support
Message-ID: <20200930053425.GC31821@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-4-nicoleotsuka@gmail.com>
 <5a91f07c-bc27-7607-915c-e98a7a0c4b24@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a91f07c-bc27-7607-915c-e98a7a0c4b24@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 krzk@kernel.org, jonathanh@nvidia.com, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org
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

T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDg6MTA6MzVBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDMwLjA5LjIwMjAgMDM6MzAsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
IHZvaWQgdGVncmFfc21tdV9yZW1vdmUoc3RydWN0IHRlZ3JhX3NtbXUgKnNtbXUpCj4gPiAgewo+
ID4gKwlidXNfc2V0X2lvbW11KCZwbGF0Zm9ybV9idXNfdHlwZSwgTlVMTCk7Cj4gCj4gV2h5IG9u
bHkgcGxhdGZvcm1fYnVzPyBJcyB0aGlzIHJlYWxseSBuZWVkZWQgYXQgYWxsPwoKSSBzZWUgcWNv
bV9pb21tdS5jIGZpbGUgc2V0IHRvIE5VTEwgaW4gcmVtb3ZlKCksIFByb2JhYmx5IHNob3VsZApo
YXZlIGFkZGVkIHBjaV9idXNfdHlwZSB0b28gdGhvdWdoLgoKT3IgYXJlIHlvdSBzdXJlIHRoYXQg
dGhlcmUncyBubyBuZWVkIGF0IGFsbD8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
