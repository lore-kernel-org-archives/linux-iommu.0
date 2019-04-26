Return-Path: <SRS0=codQ=S4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F24BC43218
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:36:38 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58B0C2084F
	for <iommu@archiver.kernel.org>; Fri, 26 Apr 2019 15:36:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Xs33s452"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B0C2084F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F042B28CD;
	Fri, 26 Apr 2019 15:36:37 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id A19BF27DF
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 14:52:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
	[209.85.160.178])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 30F64860
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 14:52:31 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id g7so4431013qtc.0
	for <iommu@lists.linux-foundation.org>;
	Fri, 26 Apr 2019 07:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:mime-version
	:content-transfer-encoding;
	bh=48zgZZm9rHvCEp1pEqUhC0U3faF4KPhZf7qiHf9zYg0=;
	b=Xs33s452X6QtzPCMCAtjr0M4pj8fZRIA6lwgvpWwu/cIIYP/lUyae2OIpm6XQLNdKy
	AWQNsXk+6JWuzUrg6GKOlETU9g2B2AU1vA9bKtiXGdfReOwebMl/ppTKXW2J8Y0dZfke
	eXBK663QRdQNjUz8h+GoZlZb4zEddEdwng4Y8hUmXSOolJ+rYVzC/OUPSxbF7azdFHa2
	jR8sYQsEZbSj2OPxHczSLv61il9kWCTO6EAk8jXPZSFIpt8wchRUjbcNC9jGaPa+dPmX
	v0FQsMmlG4Ik/Tdpqotn/UGz+LGzLLbCmARjsbXN2GOBlVoLTRsehiLvaHRSNtZ+t8XP
	qa1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
	:content-transfer-encoding;
	bh=48zgZZm9rHvCEp1pEqUhC0U3faF4KPhZf7qiHf9zYg0=;
	b=ChTahcpRN2cC4/6/Aph0XOfyifC3lpcLABn0FuQfI3A56DS0Wr1LJDQJI961xLZ9Wx
	5Uy2iucdq+F345xCKvMO3DfHsrPRlV90nH8w+CwUAcrvG4Cz/OwA6s/+SJo2CyEM5Awl
	0IxKmCJlyPP+5RZJdXfzH83Tww9k4YscPRzvtvPSSaeLW+7kHlpx/XPCcag7uZrXiQqZ
	Bb2iGqra59bEor2xip1303Vc4DCbBrlioSwZOxtH+2HcyL5Ow5ziFZvwD958LoiWoZZm
	/+69Qgy7i5JWxxBaUiC5BzLGZ7FjbXCIDga3nCPekYA2gRc78j6xQ1KlnJynjaw1rkeN
	t2fQ==
X-Gm-Message-State: APjAAAUkzmYJa4PdIPgcqB5xC+cE8998atI2BJDygXHMLZ7JeAAJE2tB
	p3NaVQNMrn7kfYlHrPnVMjnnWA==
X-Google-Smtp-Source: APXvYqwAVI9GU8elWrhSomD5TS/PfqIKCx0Zk29tTGQeDfrgZtmKz7RRurmUfZ4VHuVfmHrwY153mw==
X-Received: by 2002:ac8:379c:: with SMTP id d28mr24803403qtc.91.1556290350226; 
	Fri, 26 Apr 2019 07:52:30 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	g24sm3642158qkm.25.2019.04.26.07.52.29
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 26 Apr 2019 07:52:29 -0700 (PDT)
Message-ID: <1556290348.6132.6.camel@lca.pw>
Subject: "iommu/amd: Set exclusion range correctly" causes smartpqi offline
From: Qian Cai <cai@lca.pw>
To: jroedel@suse.de
Date: Fri, 26 Apr 2019 10:52:28 -0400
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
X-Mailman-Approved-At: Fri, 26 Apr 2019 15:34:13 +0000
Cc: iommu@lists.linux-foundation.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190426145228.8ZT-2l9kk5ETjKatBzirzr_5E5nKbogDEWtc5TPFrJo@z>

QXBwbHlpbmcgc29tZSBtZW1vcnkgcHJlc3N1cmUgd291bGQgY2F1c2VzIHNtYXJ0cHFpIG9mZmxp
bmUgZXZlbiBpbiB0b2RheSdzCmxpbnV4LW5leHQuIFRoaXMgY2FuIGFsd2F5cyBiZSByZXByb2R1
Y2VkIGJ5IGEgTFRQIHRlc3QgY2FzZXMgWzFdIG9yIHNvbWV0aW1lcwpqdXN0IGNvbXBpbGluZyBr
ZXJuZWxzLgoKUmV2ZXJ0aW5nIHRoZSBjb21taXQgImlvbW11L2FtZDogU2V0IGV4Y2x1c2lvbiBy
YW5nZSBjb3JyZWN0bHkiwqBmaXhlZCB0aGUgaXNzdWUuCgpbwqDCoDIxMy40MzcxMTJdIHNtYXJ0
cHFpIDAwMDA6MjM6MDAuMDogQU1ELVZpOiBFdmVudCBsb2dnZWQgW0lPX1BBR0VfRkFVTFQKZG9t
YWluPTB4MDAwMCBhZGRyZXNzPTB4MTAwMCBmbGFncz0weDAwMDBdClvCoMKgMjEzLjQ0NzY1OV0g
c21hcnRwcWkgMDAwMDoyMzowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVM
VApkb21haW49MHgwMDAwIGFkZHJlc3M9MHgxODAwIGZsYWdzPTB4MDAwMF0KW8KgwqAyMzMuMzYy
MDEzXSBzbWFydHBxaSAwMDAwOjIzOjAwLjA6IGNvbnRyb2xsZXIgaXMgb2ZmbGluZTogc3RhdHVz
IGNvZGUgMHgxNDgwMwpbwqDCoDIzMy4zNjkzNTldIHNtYXJ0cHFpIDAwMDA6MjM6MDAuMDogY29u
dHJvbGxlciBvZmZsaW5lClvCoMKgMjMzLjM4ODkxNV0gcHJpbnRfcmVxX2Vycm9yOiBJL08gZXJy
b3IsIGRldiBzZGIsIHNlY3RvciAzMzE3MzUyIGZsYWdzIDIwMDAwMDEKW8KgwqAyMzMuMzg4OTIx
XSBzZCAwOjA6MDowOiBbc2RiXSB0YWcjOTUgVU5LTk9XTigweDIwMDMpIFJlc3VsdDogaG9zdGJ5
dGU9MHgwMQpkcml2ZXJieXRlPTB4MDAKW8KgwqAyMzMuMzg4OTMxXSBzZCAwOjA6MDowOiBbc2Ri
XSB0YWcjOTUgQ0RCOiBvcGNvZGU9MHgyYSAyYSAwMCAwMCA1NSA4OSAwMCAwMCAwMQowOCAwMApb
wqDCoDIzMy4zODkwMDNdIFdyaXRlLWVycm9yIG9uIHN3YXAtZGV2aWNlICgyNTQ6MTo0NDc0NjQw
KQpbwqDCoDIzMy4zODkwMTVdIFdyaXRlLWVycm9yIG9uIHN3YXAtZGV2aWNlICgyNTQ6MToyMTkw
Nzc2KQpbwqDCoDIzMy4zODkwMjNdIFdyaXRlLWVycm9yIG9uIHN3YXAtZGV2aWNlICgyNTQ6MTo4
MzUxOTM2KQoKWzFdIC9vcHQvbHRwL3Rlc3RjYXNlcy9iaW4vbXRlc3QwMSAtcDgwIC13Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcg
bGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
