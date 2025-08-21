Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC032E1F1B;
	Thu, 21 Aug 2025 15:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791845; cv=none; b=Do8TD7y4vnhFMEE3xeVExvSWcwgrCIrhO4OU7IVOsUYlteNHkwfFk9MO6AeQ7Oq7ZZao+4CIhG7SsgnItIZtN1m98LaShIepHwUwd0akD8TfQiL/Hasz8bu2rjU0ztmBsF2mg9Y8MxZSyFS01rkMHrI0m0w+CAgb0uYlDWSMIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791845; c=relaxed/simple;
	bh=aT4t5F2y67HWgbmENf4vzAFYl2ef4GaofSdzJe/3ZlA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J9qHhOgcRtW4d1Njcnf6/NWXQCdNQkCcLoa7bAdqH63+EFiR+Z2xVyqcbwTAaoE/GFa6hPK+30iXV/bsXR6JkEwqsdiDZUI4257higIRO1+1OnkfG4eWS6GKnV+Lwt7onlRAidSltKnunPLUgcexxRu/lOllTArFqpD/KQB7x1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzFM2sSS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzFM2sSS"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-324eb9cc40aso856520a91.0;
        Thu, 21 Aug 2025 08:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791843; x=1756396643; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4j3UGmCjPkpS1tmosPSouCHG7oP/SURnr100ibkxKMQ=;
        b=WzFM2sSSqzmGMLWgZp+hOj/sb7xeayun6ZOEViJIsMbUrzoxvqjwQD5KHWKJM02EYW
         stMMKJSRgLzW8/uMjirhG5zxM+TTlKef874L+51n0QkFzeSnxgve1yTa1u9He3CmsL59
         0fFki33ocEMVE15uEPiUUu+6MJpYinBbLvSquyf0a8HjD/I2GGEHfd7t8P+pel2CIZi3
         ou0MflOff7EDj2UjTwz5eoADv9zss/lsIjxDfMFFEg6RHx/AlKwPaRk7GF0w7NhZt7P5
         xDq2OPd5As/0WMlLc446rS9cdWT7gRldcNXrBiez/WsdcFuBeuSoBazQhbZIUuUkTDxY
         yhig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791843; x=1756396643;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4j3UGmCjPkpS1tmosPSouCHG7oP/SURnr100ibkxKMQ=;
        b=dT5PYjBElfpZ2LchRX5FeeT8q/qXukaZQIld7NrjCn9ngXUp+DABaU/dsBTc0029rR
         O+05qtIBO8HAAVhr/2P8sKPhzkSVaVdXNGk2q27VcesuQfTNjM1RiAkCWgBJg+cGKCGI
         z6nIadE+7kw4s3hcfHxiTUm+djO8gChljdFzNaLqJCaUbTF5nIs7Cl8g4w52P4FPkbj8
         1lZrDIc3ODDbAdGnpZj64dM/pBabob2YAlYi5PS9J9Jp1tEmq+VrbHLXG6lBM25uTnde
         AIZzXrF57fclrmQJyaqOzLczaVL0yVhQ4xrJqcs8ScDwLTDJYtPBgGQzumfjZyt3PK83
         kvBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOeGu6+M/+8GogUi+BLs1qhGrlju5S5BEdoL396F92/Yc/Id5i3soJSgjWHMBJ3mYTnmjd6w==@lists.linux.dev
X-Gm-Message-State: AOJu0YzWPCGXLoCyKfQMoDcj9nvePYyPVHhFKnhsGlew8bQCDtRzKBTJ
	NffuPcn0O710Cl0aG3RcyaIz+da7UiCNEVnJvnV+q1O7FR1AF7o7FTgcBjpvybWR
X-Gm-Gg: ASbGncsshtVYkguA9jaqV9DF95t1xnJJ3JxgKfmlFM3WSrRU+wDih8E8J9qlw6NvdDi
	oEKyPXi9uXNUTg36/rLC1B3yM33wZ3Vil3hBexhi7HNMI1is5O2PNiRJWCYAuEKNc8n5rMH2bq7
	W2QVCN9gQkEf76YcprF39s/5zIB8guD6PpZv00gHViiKZFu6NZIQyrOl1nNMbowORs8W/6TFqx5
	UGRDzSpBJWfNn3uZzVyEsgjdMaG2U6H30oDEptdqEpuF7GZOBHtwqH+Jd7m+O/9phkiFfE/datt
	9meuRe3y76HuEEPkkI1JYmJgTxTAYW30zdyPEjnwbxb2oFl/N78gMBOdu2WRYdV1y3ZqujDiQsZ
	aBSGoxXFnTcN80LthY63YYA8bKzpfrvXDYBTSNdFsUnJ9H7k=
X-Google-Smtp-Source: AGHT+IF9e73V5L0GJ4m8c/wyYuFTuRvWMYZBEUvb8sVuZ4sk4ob+Qxwo84ji2NVWtD5/HFf92Hoh8Q==
X-Received: by 2002:a17:90b:3d09:b0:31e:f30f:6d3b with SMTP id 98e67ed59e1d1-324eecf9b08mr3700392a91.2.1755791842544;
        Thu, 21 Aug 2025 08:57:22 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:21 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:38 +0800
Subject: [PATCH v3 1/9] dt-bindings: mailbox: apple,mailbox: Add ASC
 mailboxes on Apple A11 and T2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-1-14a4178adf68@gmail.com>
References: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
In-Reply-To: <20250821-t8015-nvme-v3-0-14a4178adf68@gmail.com>
To: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>, 
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>, 
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>, 
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org, 
 Nick Chan <towinchenmi@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1364; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=aT4t5F2y67HWgbmENf4vzAFYl2ef4GaofSdzJe/3ZlA=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HUUPbE15NZosT3IEFTJW+24ZWMhyU+JoV2Q
 WVUeBbwX+iJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1AAKCRABygi3psUI
 JGkXD/94d1kksoerwXSsMGQTysYOmWY5f/NO8PwqSESSbEBiHoUzVpro88j7yHlZRZPsLcHVgEJ
 fV3x+1Cx+oG8xSCvCMNjXkAog2MeESRudOKu1Ci2lJTAPOpqqDqwwXisGo4z8cyYqUcnrwBEItc
 UBgM+DbloO6ILChq0OLXgqRdrPKNBe79MljNt7/lDE5jOaNAv6O6gXwpisv2Hv1CrosG4DnzqdM
 ojiv21uaEkKAATAOBonffdQ8hCdiAUBNSOZ94s4vq0sewDAYLsNTJKbGvTerIXlZWHXv8wSP98o
 qXoCBS2HVRiUG3K0/oSJSTwGyCZKvQcAgDrmgVi+v6oUuX+7zmzU7CZziPDn6b54EQAR9SlDaCQ
 oZ9U8vQxAFyY6SH1j6siKQlLpONcSCCrwtaDZIS/KGGa1iWforS7wdL8SKUchqx0rN8fhI6xkFS
 2Ja6Z+0X/kwzFk1/1cUHj6hzczTN++6Bj03CUax0Zdu045eHn0o9F+ibkL2zVctLyUyqGYBuse4
 nRizdxC2T4CzG5yi7Pkix+hlXQaJF8qH8E8xcL5r1MLXI7IH0HYaCwrmOaRDmENWk3jNzZ1votX
 gJQT0L8qelm1fG43gboJ6BTIIW+wO0lpILMEWoshhZoeH8VCty0DQ5SJRKDaKUnVCJBZ5+s9E5L
 Twjq02ZQc7UuNog==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add bindings for ASC mailboxes as found on Apple A11 and T2 SoCs. These
mailboxes are used for coprocessors including Secure Enclave Processor
(SEP), the NVMe coprocessor and the system management controller.

Acked-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
index 474c1a0f99f34777e1bed7fc0a34f89320a93b7c..bdf58f03b84833ecd93a34b91f6262d1706a002d 100644
--- a/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/apple,mailbox.yaml
@@ -33,6 +33,13 @@ properties:
               - apple,t6000-asc-mailbox
           - const: apple,asc-mailbox-v4
 
+      - description:
+          An older ASC mailbox interface found on T2 and A11 that is also
+          used for the NVMe coprocessor and the system management
+          controller.
+        items:
+          - const: apple,t8015-asc-mailbox
+
       - description:
           M3 mailboxes are an older variant with a slightly different MMIO
           interface still found on the M1. It is used for the Thunderbolt

-- 
2.50.1

