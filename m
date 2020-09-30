Return-Path: <SRS0=Vh7E=DH=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60482C2D0A8
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:45:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE7F82074B
	for <iommu@archiver.kernel.org>; Wed, 30 Sep 2020 05:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhrFErRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE7F82074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8E7A98679C;
	Wed, 30 Sep 2020 05:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S7gbjg6+TTpT; Wed, 30 Sep 2020 05:45:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E219986749;
	Wed, 30 Sep 2020 05:45:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8E49C0889;
	Wed, 30 Sep 2020 05:45:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5CCACC0051
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:45:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2C3D91FF11
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:45:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SHZKrxZvO9LR for <iommu@lists.linux-foundation.org>;
 Wed, 30 Sep 2020 05:45:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com
 [209.85.210.193])
 by silver.osuosl.org (Postfix) with ESMTPS id 36C7720009
 for <iommu@lists.linux-foundation.org>; Wed, 30 Sep 2020 05:45:02 +0000 (UTC)
Received: by mail-pf1-f193.google.com with SMTP id w7so407342pfi.4
 for <iommu@lists.linux-foundation.org>; Tue, 29 Sep 2020 22:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to
 :user-agent; bh=tRdqtpZuO9VlHAKM9EV6SLp/Vc7sBfzATqlbagqH/RQ=;
 b=mhrFErRMevyjT/bOEjjKelhWvNvAibIO1NgK0kCrxYY+Mn3CjdF4KMDtEEDICHufYJ
 Isu/HtYsFFcMc4QN1gBhecO1xetvZjTKys1XgJJlJq3zo4KPCCuGaV8cAd1FNamDl+wY
 ahthsSaCvfl6NdlCGZdmASnLmzu7u3Nb9Djg3MHIrSLOE71AzHUDEBRmDBr2va3+Es+V
 wXuE07ZdqzPw74kWYqE5KGH6pB/S88RNm26zGXfF1mW/LW/rrq6dNEoOIPGa0Oy+QkyV
 5jPMjKSJsGaa+B5QtFtho1CFwb17QELUQUNv7/AdcPzOoqbkP81ffLIzS4P3rnUNfnOR
 B3DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=tRdqtpZuO9VlHAKM9EV6SLp/Vc7sBfzATqlbagqH/RQ=;
 b=a43jlzM5F4UEzy8whRRxlFytZtrBUy3PCt77nyhPEMht57Rr5MlHM+2tHJ1IeJxeyw
 H2yqJgbL/i2P8j2MDhpRz6cYZfgYH6t7EKBtytcr5dCUGotupvwUUjoeQ4obnJLDezJE
 RHxS+BkA4uJir0F5WvP17wP58I3Hwi601AQPA6fOTB9jMDopvBnI4iXELmVQHH3o3uJ7
 RT77v1zl4q6sclOyoc8944ejOZVUlZ+FrTfA049IYh6XBT8tTXd9cnsiv3eGxDMchomy
 ALU+GMnWyINxUjFkE7GYwgnv48HAmq6/3ePxTf9m7PlKV4AzJfLsoOei4gFC6XNXu1Nk
 ZUqg==
X-Gm-Message-State: AOAM532vErMgfTc/upNquci3/LgiEqMJCGvvbEu9vatVi8jAdL9SvbrO
 g5gw4S0nSz+FfndqyRhmZnE=
X-Google-Smtp-Source: ABdhPJxXrv4hwyUUnyZdUCFlV5myhX0PXPJKHvHr4ZoQqkPu2YBnDMM4+FKYJP/Iw+xdaZPedJXj/A==
X-Received: by 2002:a63:3448:: with SMTP id b69mr902755pga.269.1601444701732; 
 Tue, 29 Sep 2020 22:45:01 -0700 (PDT)
Received: from Asurada-Nvidia (thunderhill.nvidia.com. [216.228.112.22])
 by smtp.gmail.com with ESMTPSA id 123sm650855pgd.83.2020.09.29.22.45.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 29 Sep 2020 22:45:01 -0700 (PDT)
Date: Tue, 29 Sep 2020 22:39:31 -0700
From: Nicolin Chen <nicoleotsuka@gmail.com>
To: Dmitry Osipenko <digetx@gmail.com>
Subject: Re: [PATCH v2 2/3] iommu/tegra-smmu: Rework .probe_device and
 .attach_dev
Message-ID: <20200930053930.GD31821@Asurada-Nvidia>
References: <20200930003013.31289-1-nicoleotsuka@gmail.com>
 <20200930003013.31289-3-nicoleotsuka@gmail.com>
 <03710107-b6ad-5256-4550-09c610d0fded@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <03710107-b6ad-5256-4550-09c610d0fded@gmail.com>
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

T24gV2VkLCBTZXAgMzAsIDIwMjAgYXQgMDg6MjQ6MDJBTSArMDMwMCwgRG1pdHJ5IE9zaXBlbmtv
IHdyb3RlOgo+IDMwLjA5LjIwMjAgMDM6MzAsIE5pY29saW4gQ2hlbiDQv9C40YjQtdGCOgo+ID4g
KwkvKgo+ID4gKwkgKiBJT01NVSBjb3JlIGFsbG93cyAtRU5PREVWIHJldHVybiB0byBjYXJyeSBv
bi4gU28gYnlwYXNzIGFueSBjYWxsCj4gPiArCSAqIGZyb20gYnVzX3NldF9pb21tdSgpIGR1cmlu
ZyB0ZWdyYV9zbW11X3Byb2JlKCksIGFzIGEgZGV2aWNlIHdpbGwKPiA+ICsJICogY2FsbCBpbiBh
Z2FpbiB2aWEgb2ZfaW9tbXVfY29uZmlndXJlIHdoZW4gZndzcGVjIGlzIHByZXBhcmVkLgo+ID4g
KwkgKi8KPiA+ICsJaWYgKCFtYy0+c21tdSB8fCAhZndzcGVjIHx8IGZ3c3BlYy0+b3BzICE9ICZ0
ZWdyYV9zbW11X29wcykKPiA+ICAJCXJldHVybiBFUlJfUFRSKC1FTk9ERVYpOwo+IAo+IFRoZSAh
bWMtPnNtbXUgY2FuJ3QgYmUgdHJ1ZS4KCkFyZSB5b3Ugc3VyZT8gSSBoYXZlIHJlbW92ZWQgdGhl
ICJtYy0+c21tdSA9IHNtbXUiIGluIHByb2JlKCkgd2l0aAp0aGlzIGNoYW5nZS4gU28gdGhlIG9u
bHkgdGltZSAibWMtPnNtbXUgPT0gIU5VTEwiIGlzIGFmdGVyIHByb2JlKCkKb2YgU01NVSBkcml2
ZXIgaXMgcmV0dXJuZWQuIEFzIG15IGNvbW1lbnRzIHNheXMsIHRlZ3JhX3NtbXVfcHJvYmUoKQpj
YWxscyBpbiB0aGlzIGZ1bmN0aW9uIHZpYSBidXNfc2V0X2lvbW11KCksIHNvIG1jLT5zbW11IGNh
biBiZSBOVUxMCmluIHRoaXMgY2FzZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KaW9tbXUgbWFpbGluZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2lvbW11
