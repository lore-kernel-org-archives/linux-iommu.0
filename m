Return-Path: <SRS0=pxo5=UG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51942C2BCA1
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 21:09:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1408720868
	for <iommu@archiver.kernel.org>; Fri,  7 Jun 2019 21:09:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Y8xkfHK1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1408720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lca.pw
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id CE35A19AA;
	Fri,  7 Jun 2019 21:09:30 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 210EE1606
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 21:08:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com
	[209.85.222.171])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 0144BA9
	for <iommu@lists.linux-foundation.org>;
	Fri,  7 Jun 2019 21:08:40 +0000 (UTC)
Received: by mail-qk1-f171.google.com with SMTP id m14so2136938qka.10
	for <iommu@lists.linux-foundation.org>;
	Fri, 07 Jun 2019 14:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lca.pw; s=google;
	h=message-id:subject:from:to:cc:date:mime-version
	:content-transfer-encoding;
	bh=E4XEGd4DqdBQRyG19CHJo5811yC3cY/TwcQ6u8XftFo=;
	b=Y8xkfHK1OZ7tf/p7+OEuKsd86A4js8cJVS0t5BgppRwxS23p5R5zyKuTN0dz+Mo88x
	6uQFnQ91U/bHhDQWfnqC8RxR0jv3HhyvLlm8vaOqxw2Z5eR0sav++IN1KdJd9dYV5Y3C
	fT5D+62A0l5OqoXpNsTuB5Erk9sL2zY/DCOSTw4juP43K4xzPn69nzkPxuuoQVJFOz2c
	4qbadClltzYLOXmxGzSDkkOmai7TskMPMOUDiNwA85HCOKvALa880+3+opO1/a2YvMgd
	7+x2N0THC1GoVWsNPk5j9pADsXpGD8InJ9LkLs0r8XJZol1dtoXStIsatT9xlo4Kbcdo
	VksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version
	:content-transfer-encoding;
	bh=E4XEGd4DqdBQRyG19CHJo5811yC3cY/TwcQ6u8XftFo=;
	b=nHTPPsVVs01DxL6pAYbtTNb+l9h9AXHy+sNYbAcoGNcmLzvWVljjvmPBzhRw6umkku
	QgvsfBl3MeBDUcvg7f83DgfZdryEuB/WL1z0IWaC6BzBVjliiNhEq5qSZTMcGqsRYqV7
	C0o210CZoXBLXt/ea/FLTzsIyzyzxB9ii8y7I/PWSKXG/uV0IX3eU3vSq1Cakl3bl+0u
	hPkitsS821zCk1eiJVk9AIc8oyCOVrziPi6od9RMpQmOaSjcsoAvL1oCS9XEhoDM/cy9
	0DsnZN2cARBkRwt5S5GWfXxcedcjdHTsMFbDcp2N8g3sqqyq7Fz9av4RF5wJrpBosxVY
	AZyQ==
X-Gm-Message-State: APjAAAX35FbEtRqMGI7w4WzfpkrChwNeNnzJvXwEBnWPANdMWjRlBuZk
	WejHsN7siO6/KsUDiUDCXQoz+g==
X-Google-Smtp-Source: APXvYqzB1xYDxn6tlil+RdfJuoEo0ORYAGfENTnBCZYrw4vak0QBv8QAHAPZwlXqLe61VwGLoTl4+Q==
X-Received: by 2002:a05:620a:1425:: with SMTP id
	k5mr44972163qkj.146.1559941720051; 
	Fri, 07 Jun 2019 14:08:40 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com.
	[66.187.233.206]) by smtp.gmail.com with ESMTPSA id
	i55sm2291302qtc.21.2019.06.07.14.08.38
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 07 Jun 2019 14:08:39 -0700 (PDT)
Message-ID: <1559941717.6132.63.camel@lca.pw>
Subject: "iommu/vt-d: Delegate DMA domain to generic iommu" series breaks
	megaraid_sas
From: Qian Cai <cai@lca.pw>
To: Lu Baolu <baolu.lu@linux.intel.com>
Date: Fri, 07 Jun 2019 17:08:37 -0400
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Cc: Joerg Roedel <jroedel@suse.de>,
	Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Sumit Saxena <sumit.saxena@broadcom.com>, iommu@lists.linux-foundation.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

VGhlIGxpbnV4LW5leHQgc2VyaWVzICJpb21tdS92dC1kOiBEZWxlZ2F0ZSBETUEgZG9tYWluIHRv
IGdlbmVyaWMgaW9tbXUiIFsxXQpjYXVzZXMgYSBzeXN0ZW0gd2l0aCB0aGUgcm9vdGZzIG9uIG1l
Z2FyYWlkX3NhcyBjYXJkIHVuYWJsZSB0byBib290LgoKUmV2ZXJ0ZWQgdGhlIHdob2xlIHNlcmll
cyBvbiB0aGUgdG9wIG9mIGxpbnV4LW5leHQgKG5leHQtMjAxOTA2MDcpIGZpeGVkIHRoZQppc3N1
ZS4KClRoZSBpbmZvcm1hdGlvbiByZWdhcmRzIHRoaXMgc3RvcmFnZSBjYXJkIGlzLAoKW8KgwqAx
MTYuNDY2ODEwXVvCoMKgVDMyNF0gbWVnYXJhaWRfc2FzIDAwMDA6MDY6MDAuMDogRlcgcHJvdmlk
ZWQgc3VwcG9ydE1heEV4dExEczoKMAltYXhfbGRzOiAzMgpbwqDCoDExNi40NzYwNTJdW8KgwqBU
MzI0XSBtZWdhcmFpZF9zYXMgMDAwMDowNjowMC4wOiBjb250cm9sbGVyIHR5cGUJOgppTVIoME1C
KQpbwqDCoDExNi40ODM2NDZdW8KgwqBUMzI0XSBtZWdhcmFpZF9zYXMgMDAwMDowNjowMC4wOiBP
bmxpbmUgQ29udHJvbGxlciBSZXNldChPQ1IpCQo6IEVuYWJsZWQKW8KgwqAxMTYuNDkyNDAzXVvC
oMKgVDMyNF0gbWVnYXJhaWRfc2FzIDAwMDA6MDY6MDAuMDogU2VjdXJlIEpCT0Qgc3VwcG9ydAk6
ClllcwpbwqDCoDExNi40OTk4ODddW8KgwqBUMzI0XSBtZWdhcmFpZF9zYXMgMDAwMDowNjowMC4w
OiBOVk1lIHBhc3N0aHJ1IHN1cHBvcnQJOgpObwpbwqDCoDExNi41MDc0ODBdW8KgwqBUMzI0XSBt
ZWdhcmFpZF9zYXMgMDAwMDowNjowMC4wOiBGVyBwcm92aWRlZApbwqDCoDExNi42MTI1MjNdW8Kg
wqBUMzI0XSBtZWdhcmFpZF9zYXMgMDAwMDowNjowMC4wOiBOVk1FIHBhZ2Ugc2l6ZQk6ICgwKQpb
wqDCoDExNi42Mjk5OTFdW8KgwqBUMzI0XSBtZWdhcmFpZF9zYXMgMDAwMDowNjowMC4wOiBJTklU
IGFkYXB0ZXIgZG9uZQpbwqDCoDExNi43MTQ3ODldW8KgwqBUMzI0XSBtZWdhcmFpZF9zYXMgMDAw
MDowNjowMC4wOiBwY2kgaWQJCToKKDB4MTAwMCkvKDB4MDAxNykvKDB4MWQ0OSkvKDB4MDUwMCkK
W8KgwqAxMTYuNzI0MjI4XVvCoMKgVDMyNF0gbWVnYXJhaWRfc2FzIDAwMDA6MDY6MDAuMDogdW5l
dmVuc3BhbiBzdXBwb3J0CTogbm8KW8KgwqAxMTYuNzMxNTE4XVvCoMKgVDMyNF0gbWVnYXJhaWRf
c2FzIDAwMDA6MDY6MDAuMDogZmlybXdhcmUgY3Jhc2ggZHVtcAk6Cm5vClvCoMKgMTE2LjczODk4
MV1bwqDCoFQzMjRdIG1lZ2FyYWlkX3NhcyAwMDAwOjA2OjAwLjA6IGpib2Qgc3luYyBtYXAJCToK
eWVzClvCoMKgMTE2Ljc4NzQzM11bwqDCoFQzMjRdIHNjc2kgaG9zdDA6IEF2YWdvIFNBUyBiYXNl
ZCBNZWdhUkFJRCBkcml2ZXIKW8KgwqAxMTcuMDgxMDg4XVvCoMKgVDMyNF0gc2NzaSAwOjA6MDow
OiBEaXJlY3QtCkFjY2Vzc8KgwqDCoMKgwqBMRU5PVk/CoMKgwqBTVDkwME1NMDE2OMKgwqDCoMKg
wqDCoEw1ODcgUFE6IDAgQU5TSTogNgoKWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3BhdGNo
d29yay9jb3Zlci8xMDc4OTYwLwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
aW9tbXU=
