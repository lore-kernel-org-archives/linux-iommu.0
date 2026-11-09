Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184432;
	b=QklGD3lEOAl4DuznPHNB6N+tDBQzj9czZNKglSxonY9LvTnqQQfUqWb384kkhvjdBY6r
	 eHg5tkSb5lG6GZSIcSbzZo9HHoPW9CELs5sexiaB3vUaPztGpTILAoPC5yetTrUMjMuT9
	 4kT+fO6TP+uRejuCc7dGEbkyqeAx4ntL+K5B5KOtUTOxDNN6o6bQpUk7tFwlx754eadv3
	 x1k4Tlc7KfIp7NCPnQHw7wT4wlYFJ9hN745cs+Af8cAsNp6q+n6dSQKl8ja/OWUKJ/tiy
	 ajXY1MU1wJUrmx+yYMsYI+c+L+nkdMRAr99XvUaFJQ02vkY3vfv97mNFK+6PSHfEPdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184432;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
	b=WVz2J1JyPP3jpHrnT2F5Dg+oCYcIqT5LCX2E5JNQLwHQW7TIFk6etJg9d/FTUXlK3ZKg
	 JEa+LH0n0Y+BXtqRH4sQhmFUJq4j1vqp7/b25QH5wJEYidrBoRHEO4iADmzSgxFBC6MRd
	 mgY9wQVwVNlNDH4Gr7t1VoIHfabg3xUNiAL6ln2t+1EN/J07S4qIpakCmgmy/dPXxrIUC
	 Wi6QvuWbtsTeXdXoFMAXzWiT8fajzxadpqkSnC6DcOpKgz9ibeCuSwpzZWTo5/vigsVh6
	 BbrqRs4XEqzX1Z9P5zu81mko/Co2jLzigXSUKRpnfy25SU4+lwQfr6UxEYxG28Zcprg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aPgHnr20;
	arc=none smtp.remote-ip=209.85.221.46
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B21606D807
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:33:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76B21606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aPgHnr20
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4910b863b84so218750f8f.0
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184430; x=1794789230; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
        b=aPgHnr20A8mvcR6Enoud3cKU+FtjKqLiHQhjo44ZfFCfFlKa/5r+dMa+vbDWqtZffu
         pyH8ItsI1Z3WzKHFwQv317eQD7+2hOL/S40Uukk1zjekRZS3ISFRcGqKzmV/lKQmkoE5
         TDy+1by5FKbRtwc+Lk1uR8yTIWy4kHxi7aZtnN3SeICP+StyzuIDO+3fyo2bbjpSrhYA
         LjbFQu3kqam5U0olgs6fu5hLGPuhG1zfKrhdiDr7PrCBGd6XGgfVU1fmhPkftpf37pj0
         v576eNgHXN+IR2d5qCIrO9WXpoJj3CAf7J/UCjxvOddnoQF1jhdg4FLJeZtC1pYSY5Oy
         Cobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184430; x=1794789230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vT2VNwBxc63eyIezByShTBVkpV/95J6JPEp1UHJT0Ow=;
        b=BVOiisRZJ3q8D7Q2QiAPgI/Kh99zZ8uxKYtcRsAzSs9leO7JwGSXD0YaDRwhoEWyse
         bLGqp0YRWcR4X6A3lTYf+RXSGce4osWWFovBoij/HQnazO/rfe99KiDzNVXEso1BUA6p
         3VFWz2XlRsSUKlII1VDkG8qAEXz/wiy9xJe4ZC0oMb+bdfOpjr7S+uzAv1FOm2MenVqp
         ny0MPA/8seWb0BzFmOSvD70xXiKy1MPWrYq9R5oEovaJbmcivI9+1Kx89P0LA1kLEb67
         xBN3FpYR725em8qivdKXx5DD6x4I4YAlA4dc95AcaeDBwP4p3KQx2zcZcEgZjRycol1m
         Ku3Q==
X-Forwarded-Encrypted: i=1; AL+hErGgzGbRHbPHqyRMhNFM6Q8CZE3Nt49VYd1kIuFOroM5y+RcTEU7uGy/eANhATwr/BL6+rKGXw==@lists.linux.dev
X-Gm-Message-State: APuU4Z97biZQsFccUvWI7ghR8yyN/P9N5UGu9EL4xQrngAInUbnNf/h5
	oM8FCecr3OOE/se6Mf0X9LkGDwVvbml2GVeERV5IcvXFMoTrv1juEyKL
X-Gm-Gg: AYBFou1cKmfRR+tvTm3pzq+OKzFomdsoTnspC6eyXX0qoEap9/HTFprBKuVGee4WD7k
	toueA7+Gwd3/7KcLLH1a0BgMkeiBeR4MSLGnB4kv19zhEcxzuE0IwV+pIP7xPVN7KKS6bAk/STH
	sUejB98Om4oj/xSYX+T07ZdfCdulKXo9nZg9vaqa7wiOMv+XUmPCSBC0/ETTxDv0o/ASZr1Yny7
	uqad1Sb2qAiIupcL+ZqAzMG6SDoVe9XMGCqfCthm+e4PwYlwHDz6cHcU7yKC6e+WD/PMgUBsPNX
	54TOVkuxG+zzeqeh6BldVZFgT1ul7RDbZ69Cg1B54Oc0nhPY+uhDBAYlmcLmFJBgeiM6HdOE0VR
	Q5KgMAAsMjA+7lAPnOpM4pB7fmwrJ1rXpCLgyjWoiUrTGnxEZaeqWwNlp7olChElMDpFD/W1Df/
	UhKMuRJHmyll5pI/MgayNAkhCO2OHqeTA1bTRzYiuHkDTW22oQSxlBai9VPNQe5BfBhGGNroj+2
	09Oav/IzkJXcnU9MK8BOSZNiJE+EHbfpKRWYwL1sqCZi3YZHOnXmqlEdymcCgoUxS7NFuu1ALkl
	EXGB9ImqPHD+jthZmmSigRKGk+IZNXEGc94fDI+t
X-Received: by 2002:a7b:c34c:0:b0:4a5:9224:fa10 with SMTP id 5b1f17b1804b1-4b8205a7b74mr74612065e9.18.1794184430004;
        Sun, 08 Nov 2026 16:33:50 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:33:49 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:17 +0000
Subject: [PATCH 05/17] dt-bindings: mfd: qcom,tcsr: Add Halliday TCSR
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-halliday-dts-v1-5-289114ab8197@gmail.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
In-Reply-To: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Robert Marko <robimarko@gmail.com>, 
 Guru Das Srinagesh <linux@gurudas.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Radu Rendec <radu@rendec.net>, Lee Jones <lee@kernel.org>, 
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Wesley Cheng <wesley.cheng@oss.qualcomm.com>, Vinod Koul <vkoul@kernel.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Bart Van Assche <bvanassche@acm.org>, 
 Bean Huo <beanhuo@micron.com>, Stanley Jhu <stanleyjhu@google.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, Amit Kucheria <amitk@kernel.org>, 
 Thara Gopinath <thara.gopinath@gmail.com>, 
 Daniel Lezcano <daniel.lezcano@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Lukasz Luba <lukasz.luba@arm.com>, Georgi Djakov <djakov@kernel.org>, 
 Sibi Sankar <sibi.sankar@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
 linux-usb@vger.kernel.org, linux-phy@lists.infradead.org, 
 linux-scsi@vger.kernel.org, linux-crypto@vger.kernel.org, 
 linux-pm@vger.kernel.org, Stanislav Aleksandrov <lightofmysoul@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=720;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=sz0jgm6yJ2qfmdfMMgsqR7Wg9ExS4UZymLewfvVCvH0=;
 b=uUjeKsqz31kCcfPZSa8Z47M4B7r1CADYAoSad8joeZDRvAbLwLDkhf9ZDymLvxVoerAVE+UqI
 g/farVtv7C7AYkuFx6U6v9lz+2+4yx0RS/OmA8jjU0ljraJ4I1qJLhy
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the TCSR block on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
index a021e4dea486..e8a681b5e6ad 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,tcsr.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     items:
       - enum:
+          - qcom,halliday-tcsr
           - qcom,hawi-tcsr
           - qcom,maili-tcsr
           - qcom,msm8976-tcsr

-- 
2.55.0

