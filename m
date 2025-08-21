Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD71227E07A;
	Thu, 21 Aug 2025 15:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791876; cv=none; b=L2TjdiCaud78YLw3LkFHTe/PDL4Ebcz1BzxMzUTgHa/rcUrC32EbRtIJDgW2iWWFdI7Wu4foMU6vObvICvaKEGtXJ3hbpr0euFZDVmEKSJxMf7hKZTXYT30khaRf4ft3vhBaHCUd1cWvhyvQ7/y34Oel7of/Ay41SCSDCiJJ1RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791876; c=relaxed/simple;
	bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TQoLVyW1oOwY+HtGJwDy62ZmUKxL/9KSEYdPSoeRJmCVEahqP46uGNfUZ+jaY20vHC7aXwhB+sj/XY810o7Q3jQmOUwaSA3oar529n0mDe0C8NO18pBEIFH2Rx9pR0HFzEpipEJvpUCul4j68o5ux5qC8bEonuxvDgzlWf258Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GpbLN9oo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GpbLN9oo"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2eb49b83so890831b3a.3;
        Thu, 21 Aug 2025 08:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755791873; x=1756396673; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=GpbLN9oosloZB8qD5MEKoCNpdovncTSmu95P5EmV8+ahKcs7G4f1zVMSpjLyE/e87x
         O0HEkkBp8J8iR8AbqfqLYy9V6+Ynjf1/PWvFd09qnZfDn+TvHHJ6ryQwgXl7PDVCEjkO
         zW+82Tx/Gp6VFzGeDw8Y74ykgwSA/RWLGvU6zkIDBeXfNM8KqqyWjz8bbCVUbhAy5bmd
         vr52b6obU1RhlQDlMo6+IZP8vjLE3JAe9aqMRqAcXqqlFoyoK+fNDX8pYWh+VJWWeCHb
         MDMiebzQ7U2psE17J7QBU6/RLs/qpftoIztL52yIyATS6/VTVAr0GGmj8sd4m6v3fNzs
         kxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755791873; x=1756396673;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8BEwZHZ+L3ilTH9rJUZDkczC6u83Mtp4BtglFfrqDMI=;
        b=EYg5jXUeaVZQgcr+fEZDJ8g/ScK9LKCr83NqtNmhPsJc8mJ2TxdFIkDUvTyO+Fvknh
         1bdU/thc9dD/A1htOk9kvhY5tTGRCK7/yX5spdEkNwjsy/2CeL8W/C59jVQlQPApqGqa
         4JPOcCcIJDhQggpDCdLt31gkkQKFavOseIVRsMx6UqPXMHgdDT4LGPdMIexB1NraYF1N
         l/WrQ/+FaXXO77pEyPXvwQtUIPVteXyFKlwngaa55TtFFhH1IkBTNti/89VHipf9XqrM
         ZkRvkv0LyAUtEJ2evmoRTwl161umuNmyPqIcy9gAZdCxG7tNgmP36q9sdNlh3YvvXGo6
         Xz9A==
X-Forwarded-Encrypted: i=1; AJvYcCVvE9CmWtfZbTeKPgszcBEqQ0Udyia6MpmQmY91l8nwPGJqZVYhgLN5r7/pwQohVyXIYosE6w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw6ZA6NpXGXmO4+FO4qqVyrb/l9sNrx2jEXmsb2Y0lJTw0WDxyA
	vF4u8nURguxYndcw8TZ0bYgwjcS1oxlTY29rZptb4oiI+j8zMeue5YRPUfeP3zRh
X-Gm-Gg: ASbGnctNiaVZb7nWKENa5RuoOTuO11rQyy2T8o1QjAtjTQu8pHnWuec7Ze8ZaqXXdXH
	I4LsGwdUldLTcw+poQyQVeNg6yIxx6f58LFNnywMEMxQFFBhPxg1AdepgE4B7qSSASp6gWPNkOE
	zYHLFpAOuITGXAJ/YhzrmCdB2gqIdpiZaB6Ez4q62U6H+/e2DXtqUMV5cynLlAaOptgJOtSxWvT
	WtV0k6dpvvTw2ZcpkiInBoZpMiDWzZTnULM8dSny8A7BNFVezfSGCtcpyhXLY1r9nGFIw8/g5RC
	VKhb+2IQf/3xG+s+W8CvhIEfEICREc0xv4iDuMQlpiiOkz24cSlF5CW6qGQZ/BeESN5TprlGxJ4
	Q9lSKFFTHkctecZS9MBgBhH5S2Vx8lwhcGrE6iyYCCttjuKQ=
X-Google-Smtp-Source: AGHT+IGl8DhfBnfyyRb/1wuIt4ZnuuK5v/ajSI18QqjSW5uA5+dCScmkCcOWU0FTW5Qiao6GY4NPmg==
X-Received: by 2002:a05:6a21:999e:b0:243:78a:828a with SMTP id adf61e73a8af0-24330aaa986mr4832755637.49.1755791873031;
        Thu, 21 Aug 2025 08:57:53 -0700 (PDT)
Received: from [127.0.1.1] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b47640afb33sm5094320a12.38.2025.08.21.08.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 08:57:52 -0700 (PDT)
From: Nick Chan <towinchenmi@gmail.com>
Date: Thu, 21 Aug 2025 23:56:43 +0800
Subject: [PATCH v3 6/9] dt-bindings: nvme: apple,nvme-ans: Add Apple A11
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250821-t8015-nvme-v3-6-14a4178adf68@gmail.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1310; i=towinchenmi@gmail.com;
 h=from:subject:message-id; bh=UCisHMuxtAwW4uphlmL614TcUp9WjlCZlTIn0NRlWVg=;
 b=owEBbQKS/ZANAwAKAQHKCLemxQgkAcsmYgBop0HVe+SYcZ4v31RCzG+zBlarAEg9e5w9fD6uT
 6uHdqv3tdGJAjMEAAEKAB0WIQRLUnh4XJes95w8aIMBygi3psUIJAUCaKdB1QAKCRABygi3psUI
 JKl0D/9L0mE7dXU2s95VtJEOhw9hiZJoAf0kmkheBDiq2ex+CgUM9689RXA8Q5UIFgqG3HwcT1u
 qdSi9MwNSV+DmDZa0NteXj/QA3FPkz2wu1qFqwGiTDMOt+V/nB0yK29xB6a8mkzdQU9BI5GvCtj
 8iupQqETr3cuFkQ/wUH4OfFwgxxN2TBlOLUPedcog2Esg1Gdl/oS4VKymOgOMEZTJkWWGzUCvH1
 Tb7gEOdgDmdt86gzbH4R8hC/a5NPIdw//ESycyj+0mAOn/CRpGSz1ql9cTzfrAEG5XjqAd76dar
 xyFOG28eH754ZioFrxEA4nbNtZkptM2JQUyxJrnafS7BkydNBN4ihW6ZXT6FgB59AVUT8CCKUo7
 IOKblLdv3m104dkriKSm5IN8RO8GI23IFnvmRkn7NB93PeEp8nc+F+SpZep9I+aODBxxnavPfBB
 LW3TVrL0QsMpDU3YzP9g4SEqFSswAzJDLKv/JR21yoFbYH5yZmaxtlcqk58X+apLffev2Rt12EJ
 tnQQKquhH/Awk+CFvyVMSo4sswgvsdXpdpjP5wLqW/iXt10Hfn5VTnpkFAoRD47IuJxfVdlR7A1
 B7W234hW/PkZgtLyYnAkThuEdXQHpKthI3H5Ht49QcHOXhTJHAWD0CDaO2ACod2v/gRFQ5+TL16
 Wmv/t0XQ1D945YA==
X-Developer-Key: i=towinchenmi@gmail.com; a=openpgp;
 fpr=4B5278785C97ACF79C3C688301CA08B7A6C50824

Add ANS2 NVMe bindings for Apple A11 SoC.

Signed-off-by: Nick Chan <towinchenmi@gmail.com>
---
 .../devicetree/bindings/nvme/apple,nvme-ans.yaml          | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
index fc6555724e1858e8a16f6750302ff0ad9c4e5b88..4127d7b0a0f066fd0e144b32d1b676e3406b9d5a 100644
--- a/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
+++ b/Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml
@@ -11,12 +11,14 @@ maintainers:
 
 properties:
   compatible:
-    items:
-      - enum:
-          - apple,t8103-nvme-ans2
-          - apple,t8112-nvme-ans2
-          - apple,t6000-nvme-ans2
-      - const: apple,nvme-ans2
+    oneOf:
+      - const: apple,t8015-nvme-ans2
+      - items:
+          - enum:
+              - apple,t8103-nvme-ans2
+              - apple,t8112-nvme-ans2
+              - apple,t6000-nvme-ans2
+          - const: apple,nvme-ans2
 
   reg:
     items:
@@ -67,6 +69,7 @@ if:
     compatible:
       contains:
         enum:
+          - apple,t8015-nvme-ans2
           - apple,t8103-nvme-ans2
           - apple,t8112-nvme-ans2
 then:

-- 
2.50.1

