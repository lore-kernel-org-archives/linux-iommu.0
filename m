Return-Path: <SRS0=WrXO=TR=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E64A1C04AB4
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:05:56 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B87C22087B
	for <iommu@archiver.kernel.org>; Fri, 17 May 2019 19:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rvS8Tdrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B87C22087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F3FF3C83;
	Fri, 17 May 2019 19:05:26 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 07BA1AF3
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:14 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
	[209.85.128.68])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 8AD7D5E4
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 18:47:13 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id n25so7272385wmk.4
	for <iommu@lists.linux-foundation.org>;
	Fri, 17 May 2019 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding;
	bh=Btaw5CgxhYac28zaC8EYgFvIIeyjC0ToJx7hPAKP9QY=;
	b=rvS8TdrrNuTuTAczO/sCk3JYQDiJx2zGD/6UYxqHovGm+wntVw99HRWQrWG6B6Ziup
	+eXBKtuGsJr+1pfo0wvcjK1XPoXYQOKCCDRzcSdX5Gf0G5QudaJLmAM75dro9XSfdJ9z
	UnFgsYIydmslSPMlnICV/EntlzRoteVF2Kb6B8hzHgbAI0HDkqV49pbgIrvE4Nj5R9xl
	ZKlpEyQF8ZMmSe/S6bFlC3qhXjP35nbVs8HjS0qO5AjAfWaUItFmW57IEcjJ3f1i9tio
	voD5XCP+9ELMbiBE9y+JLbCsYS1gHbGHQlmp7euB2Mp1d3Dal57AFoAqLOoXfHV3Myyh
	Ya5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
	:references:mime-version:content-transfer-encoding;
	bh=Btaw5CgxhYac28zaC8EYgFvIIeyjC0ToJx7hPAKP9QY=;
	b=LPrp08s04efAPJ1YFQt9O1KVqLQOJjTbkvcNXfk6LbxHMbOayls5FZVvGWAtoOxmJe
	bM0V491W2agHgj+OixyR//URxRXEBslUsntmDscHaiGL6Xr6Cy1LecjJeKb0DrI/oeZK
	txRH7kcyUqoXKf3BTFcqMgwqHpkGUlzsjrlGgC3LGqKnP2Fpv+uOmM61qNoEaCEajUSw
	qSwRDta3u5ll63hfOiQVtDvbJaRXX7QnWsBFUOchkIWp5Q65fwt/0/25TFtX5wZ+2cjG
	vfyRRd0W67N+O/NqA59uAcOYKPrRwbTKIB1YO7kNXevbM1bFhOxqg5KCBtMF054oEApQ
	+YMg==
X-Gm-Message-State: APjAAAX4LiPPzCEtgbk1+pH0xbbMnG/XG9YZUGqfztczYH36aArXBovZ
	os4ZLPv1GCUBlEy3mLpKzLk=
X-Google-Smtp-Source: APXvYqzArrwsBcPq+tVBrTz90U11Q0am6+wnQ5F3p77yNdgZ3iQekw5aa3vsszJncLjFku7dlsgqUQ==
X-Received: by 2002:a1c:9616:: with SMTP id y22mr3268422wmd.73.1558118832056; 
	Fri, 17 May 2019 11:47:12 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:1f1:d0f0::4e2b:d7ca])
	by smtp.gmail.com with ESMTPSA id
	v20sm5801112wmj.10.2019.05.17.11.47.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 17 May 2019 11:47:11 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>
To: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Maxime Ripard <maxime.ripard@bootlin.com>, Chen-Yu Tsai <wens@csie.org>,
	Tomeu Vizoso <tomeu.vizoso@collabora.com>,
	Will Deacon <will.deacon@arm.com>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Neil Armstrong <narmstrong@baylibre.com>,
	Steven Price <steven.price@arm.com>
Subject: [PATCH v5 5/6] arm64: dts: allwinner: Add ARM Mali GPU node for H6
Date: Fri, 17 May 2019 20:46:58 +0200
Message-Id: <20190517184659.18828-6-peron.clem@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517184659.18828-1-peron.clem@gmail.com>
References: <20190517184659.18828-1-peron.clem@gmail.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Fri, 17 May 2019 19:05:24 +0000
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
	=?UTF-8?q?Cl=C3=A9ment=20P=C3=A9ron?= <peron.clem@gmail.com>,
	linux-arm-kernel@lists.infradead.org
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

QWRkIHRoZSBtYWxpIGdwdSBub2RlIHRvIHRoZSBINiBkZXZpY2UtdHJlZS4KClNpZ25lZC1vZmYt
Ynk6IENsw6ltZW50IFDDqXJvbiA8cGVyb24uY2xlbUBnbWFpbC5jb20+Ci0tLQogYXJjaC9hcm02
NC9ib290L2R0cy9hbGx3aW5uZXIvc3VuNTBpLWg2LmR0c2kgfCAxNCArKysrKysrKysrKysrKwog
MSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL2FybTY0
L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGktaDYuZHRzaSBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
YWxsd2lubmVyL3N1bjUwaS1oNi5kdHNpCmluZGV4IDE2YzVjM2QwZmQ4MS4uNmFhZDA2MDk1YzQw
IDEwMDY0NAotLS0gYS9hcmNoL2FybTY0L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGktaDYuZHRz
aQorKysgYi9hcmNoL2FybTY0L2Jvb3QvZHRzL2FsbHdpbm5lci9zdW41MGktaDYuZHRzaQpAQCAt
MTU3LDYgKzE1NywyMCBAQAogCQkJYWxsd2lubmVyLHNyYW0gPSA8JnZlX3NyYW0gMT47CiAJCX07
CiAKKwkJZ3B1OiBncHVAMTgwMDAwMCB7CisJCQljb21wYXRpYmxlID0gImFsbHdpbm5lcixzdW41
MGktaDYtbWFsaSIsCisJCQkJICAgICAiYXJtLG1hbGktdDcyMCI7CisJCQlyZWcgPSA8MHgwMTgw
MDAwMCAweDQwMDA+OworCQkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDg0IElSUV9UWVBFX0xFVkVM
X0hJR0g+LAorCQkJCSAgICAgPEdJQ19TUEkgODUgSVJRX1RZUEVfTEVWRUxfSElHSD4sCisJCQkJ
ICAgICA8R0lDX1NQSSA4MyBJUlFfVFlQRV9MRVZFTF9ISUdIPjsKKwkJCWludGVycnVwdC1uYW1l
cyA9ICJqb2IiLCAibW11IiwgImdwdSI7CisJCQljbG9ja3MgPSA8JmNjdSBDTEtfR1BVPiwgPCZj
Y3UgQ0xLX0JVU19HUFU+OworCQkJY2xvY2stbmFtZXMgPSAiY29yZSIsICJidXMiOworCQkJcmVz
ZXRzID0gPCZjY3UgUlNUX0JVU19HUFU+OworCQkJc3RhdHVzID0gImRpc2FibGVkIjsKKwkJfTsK
KwogCQlzeXNjb246IHN5c2NvbkAzMDAwMDAwIHsKIAkJCWNvbXBhdGlibGUgPSAiYWxsd2lubmVy
LHN1bjUwaS1oNi1zeXN0ZW0tY29udHJvbCIsCiAJCQkJICAgICAiYWxsd2lubmVyLHN1bjUwaS1h
NjQtc3lzdGVtLWNvbnRyb2wiOwotLSAKMi4xNy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vaW9tbXU=
