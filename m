Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C4483BEB;
	Fri, 25 Sep 2026 09:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790329661; cv=none; b=SaxU5D4A+6KmsdSJbaNaYyhe0NfFnSfzkIumQeZNAEVKOUC0ZKabLIoYed2BFjGOAFyhD6DqIJKO8ZFcfsID3ibrJVFLlP6SuT+h4GTJsI830xgz1m23P5hcE/tcMfX28CkDr6ImuufnlPD2U+QOCR82p10AN9PL4ccPfp18zkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790329661; c=relaxed/simple;
	bh=VHauq/A2zwlPP8nlOXF4CzWsLsS2GlAVhYD21ZZ6fzM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d8NcQITdkkzcuuPc2Rt/KdJoMFRFLexH0bb1dCl/PU6mUO5kUROaLVNVcwxrYWy6yIRBt5REUmCj8yL7LwE6MiVzeS3c1Qm3Un3WcKFqhIDukLF4rTwzQv1fN7MH2iDYwZ4W0VILOq3HGH9UQ/mJq/zmEZOB1uB5rF/a/zFz4Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=AEgwzEKP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FS9A4EhC; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="AEgwzEKP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FS9A4EhC"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 75709EC0170;
	Fri, 25 Sep 2026 05:47:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 25 Sep 2026 05:47:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1790329657;
	 x=1790416057; bh=QGtfJj/2QVyXwkVd2oEpGeaL7AqDn5it/MaukwH5TUI=; b=
	AEgwzEKP5JCGD5R+lkXXu306gIanG/9WIgHg1vdm/OUfBjv56Pq5saBWKy7g4d77
	n+cx7JAxSgJ8C8hO9lnS6PUBPm+j6qlqI4+h+EvMN/tPYUonmWelSbW3ujxPIeCS
	e1vvfHVCCSnORnVcJO0JdJGt5ywXsfc2h9j5JHCWJfeYCAO1th1dKAgI8CtEB9xL
	Nco2o/WBB0PBFX2VwNGHQM4nI/7YGECs+6pzYWjrcalwHKinRJML/EIOyFszeTJL
	rnLhfhPskA776+wbz5cprAPY5nCVpj7T1CTbHuX8qlpscC5Bgrm4p49a98w8B+2J
	X8Wd6fRGiSjJW9VO/Uf5wA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790329657; x=
	1790416057; bh=QGtfJj/2QVyXwkVd2oEpGeaL7AqDn5it/MaukwH5TUI=; b=F
	S9A4EhCYsBYKQpHJtrqloMttM8ae3nnFJ12HeHywygh7vksgcKIXTrrJyraKkXeZ
	w27R65qMQM+iqyvoGHG1e4uk4u8yGy2PLtuDDlelromhC3MJUebg1omokPIiBn1Z
	lnblZ0PvD+fMpQU8lVvBUNcXgeFh1IwEkoQZt4jq/+aWHTpL9OM7/BG5kLHk2opD
	AlMEmoQsEj7QCQGg1PvBtjKrBQkRhuPDDtJyX5uuMWgvV6pNNQaMXezytRtJfYRh
	WyfCh4n2/1s317GPvuBn4F9tcJjzWt7+TTC8FlTSVru+9jEEs+EMWUfRzAwcIH3F
	EABpotXpEc5iHBh/pjm+g==
X-ME-Sender: <xms:OUO2asMbDY7BYYOVaPiiCS2CGUq_NHP9SJ_AaXjw2VEElJHd_M7g7g>
    <xme:OUO2aqCapbQD8Lzo3jKEhNOPd6pV8RPGc1PZgFVrmp-hWgupxtAyLikeTlcP4CJkf
    LOS6PBeYR9YyWPoIQEz3MN883HC00oJ_RnNBa0oQnuGsCVS1wK4Tegb>
X-ME-Received: <xmr:OUO2aq-3uAhdEUkakfgFQGNNUECMLyYxMCE8SLSYDi0lj_ScEtJ0X1hmO8u2hks7A6krtsw>
X-ME-Proxy-Cause: dmFkZTEbJhpSeMD7LDnpXCsQixag+cvxD3bFoso28WtgwG8J22LA5vwA2EmaCBywrGkNVk
    fJMjIB1Awjw+5D30C7m+Dp9Vxht3KEjZe6Lqrn96FVDODdxJTXUrAFR/eapVtvwXhviQS/
    JjIqmjL9odLytU7DATY/m+docx/hb3FWUj64crzCk+tps7ekg8phg3zCMXxYaP0Ob+waHV
    cSSktW8VoIuVmdCIqemuf0fMDG7R4dEOgW1ZWVrHKk37AKRJ6VGIvRwRezkqZ1pcO4AQYm
    oPUZAjyu+mKYQUVO4Gg0cdt3FfSRHd0FcPgbe7x6n5fIfG3GTyJW626LUIjETbYg6L0Hf9
    L7WC4e3p3kgxDcS0qluWtHix4lEm+ABtP2b1v70MG9FvESBXEK/uyUOfBRiwlfOtzdm05m
    cJJjMzp1GQcQ46LAVya07PF7mgmDkFO8mVNnz1/jG9UjAhgohkC75h/Ig96rnJLovJnPq4
    5EDsrUsZv+bAcxxmbVYf2ZjuGT5SBLJH3RaJGNxoZAjpl0n/Pe2No4Jma8CBGyuVXQ/du+
    mAEHY0pLDMUUHmtMFdiKGGifDoAEfNz1mpB6rcKuTRwwjXBDGDxUa4p5vKSWleFFf94FnX
    R8BUBzFNvt6937KJiME3v5zP62YswBbpDN3Zi7KyGJKFDDsrCnh0W+eTn7bw
X-ME-Proxy: <xmx:OUO2arEjEI3GwCuT4xaq3ehBdDaEsmaWVvRXJs44VWP3nJbUGbf0hQ>
    <xmx:OUO2ahJG1nP0MXfV6E9blaajtCXljHtqiaB4fo-XFvdKInABhXhUcw>
    <xmx:OUO2aueymaeoD7XAxxHF00lqa1AxvEdnQyTqt3FV_5B-1MSY0ZTpnA>
    <xmx:OUO2auW6T02t3fYY6odaTn7yac7zNAYAFWP_4-mkFu9xxvM6tn5zFg>
    <xmx:OUO2ailSZv2BsMq8Z9wZOANF3LnFemu_Xjm-8czTTXojdAOPrWqk7O0h>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 05:47:36 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Fri, 25 Sep 2026 10:22:49 +0200
Subject: [PATCH 2/7] dt-bindings: mailbox: Add Apple M3 compatibles
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260925-apple-m3-nvme-v1-2-5e832e2f4aa9@jannau.net>
References: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
In-Reply-To: <20260925-apple-m3-nvme-v1-0-5e832e2f4aa9@jannau.net>
To: Sven Peter <sven@kernel.org>, Neal Gompa <neal@gompa.dev>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Keith Busch <kbusch@kernel.org>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Jens Axboe <axboe@kernel.dk>, Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org, asahi@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, iommu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1153; i=j@jannau.net;
 h=from:subject:message-id; bh=VHauq/A2zwlPP8nlOXF4CzWsLsS2GlAVhYD21ZZ6fzM=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqxtzlqr/j2dW5bDv06h9NTmvd9bVro6u3dKTZiqOjP9p
 nHqS7+cjoksDGJcDJZiiixJ2i87GFbXKMbUPgiDmcPKBDJEWqSBAQhYGPhyE/NKjXSM9Ey1DfUM
 jXSMdYwYuDgFYKovbWZk2DrXWiDKb2ld47rS6RuPt9i+2Pvyu3x7UG1B45uzkn/XLmf4px9zx/L
 tH9PNh75rZl58P/Wo65qQ2cIL1ocvW8H25+mRG9wA
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419

The ASC mailbox on Apple M3, M3 Pro and M3 Max/Ultra is compatible to
the mailbox on M1 ("apple,asc-mailbox-v4"). Add their per-SoC
compatibles "apple,t8122-asc-mailbox", "apple,t6030-asc-mailbox" and
"apple,t6031-asc-mailbox" to its dt-bindings.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 28985cc62c25..9a6dfb0b2f28 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -30,8 +30,11 @@ properties:
           - enum:
               - apple,t8103-asc-mailbox
               - apple,t8112-asc-mailbox
+              - apple,t8122-asc-mailbox
               - apple,t6000-asc-mailbox
               - apple,t6020-asc-mailbox
+              - apple,t6030-asc-mailbox
+              - apple,t6031-asc-mailbox
           - const: apple,asc-mailbox-v4
 
       - description:

-- 
2.55.0

