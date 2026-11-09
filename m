Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184454;
	b=by9E80Hs0RcBUzJ9/d0lTS0lhKMa40L4KmRYLHJX/YO42B6FF+nI5/6yw8UJYAsFZMHY
	 QIaNLUXVJAdLOdl1xcKv/1cKUje1hP8hcmk3TVft0tjOmX7SPdLhmMXMheEZqzRMgLh9z
	 BwYT0Sq0mkTZYjVQ3N/O3ffrAOqOEO4aqtHW4cThLoRR9GblGZr4+ovnymBM1dlUV9Trm
	 nZenOY4HaYjQBXA3RhghxtH8LEAfq7fOx4+7p/SrZCpppIkVghARpU7z19cof5a5cPIOJ
	 bUV7VynZtp7+LHT15Fll9uPT7BxuulgPIaEakz7AtGI+G+IVGuqQal1DQf9BggipYIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
	b=uFIYaSWmRc8KjjCD3ronrX4ldsZ+MEjkXqmkczOgQBgtAjFutwJ6cZhURrBTz74MdoxS
	 V+pwZVnhTXnuxvFcvGemb0ktns0Mc+H5iahEwphjOtcBoFj6IC1tm4FLtoz3u0gN+VG1N
	 pP6PZxP5gfGqHOieCDptLMzTY4N3kfa3tH9mmVAgXngxVien7du8LzjAnvPqhLhruNW9p
	 9wRi45OeSnJoNOhLh5Ef/I8wQfL+VXvHLWP4/LnaGF+ErOGbOMJVjWgIxUWXWemL/SqXB
	 0g3SOtSKjHdwA4QhdK9SJxNfxQwtctW3rQrchsQdtjjs5W4CKws/YZh0pZGlGE9UVlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEq9HtNB;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB756082BDC
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 00:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AB756082BDC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KEq9HtNB
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491971ac844so310110f8f.2
        for <iommu@lists.linux.dev>; Sun, 08 Nov 2026 16:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794184453; x=1794789253; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
        b=KEq9HtNB5Ujed6V1HOpK+EDHPZDn9L/VcVnVVY+E9FEDWwSE4x+LwPKGztmCRGAtUr
         UfEe2QDQJvjskh+JgX0rjnvBgCoZUmqj1NGFXg2/Qc94AVDhgfQxQrpAKWFR/D4LPmmo
         g4XPVdrDqdOZKfJ/Hroqm3tOHJcTU0GBbT8obpU8t6cq5sSJ0Wo/0FZCCnKzcblFDuRc
         mpqu1y1c15I6my76PvmhHxuaA41t2rmKvvwSl+lue/OUCpo2r7GLhjgwMvId7z1fbVyH
         gVLB+4DDkgkq3uGqKxgxdVvbps0FV3tx2xgT/YNfNKxNxu0t3kPp0vMPvuSvO2KpZ8lR
         XawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794184453; x=1794789253;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=s/ljkdQydKv0eJnuPEQK47y3qmQ4duXo8otCxl59TOE=;
        b=MhxqFcVz0YAHYsU9e1lfCzAl0TIX9Cp0K/cNU8B5dGcpfr63B4XbjOFpWjVQ032a/d
         Mb25rcHd70JnpwPPXvbaYXb02tSbcW6kCQjzGugTg0nk6Hrtkw0IfG1SRCL0z/jDpp2N
         yFRG3wFrSUMnwUUSZJRdNjfuf2bYU0xZDcZx3zMMpZcjDl4b748OGDXWVb3WFnTTku3e
         Wlt84lU318dr19Eoh/xcO7K1ZxPPtdEH54B66Wx1Td8blWd82ozlW8jsdD8YHQ5ara30
         LmhLX7at5gWeDZkH/5gLyWZPC2JSDtV4HwffYn2hcEmmuhdUO7DnBpVBu0uYDdTqvwRR
         w+wA==
X-Forwarded-Encrypted: i=1; AL+hErGlBn84fANqVienSO/pRyITQohVGefo6aTayL4ekM9QBML8Clex0EYtq8bIzU5k/1xu7tS9vw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+7zXdwJDRDKWDThMpiNlHw8/qJw59Uxz2XJ27VF5iAPA8V7NVa
	c5d5APYPIg9qYPjUfV1PpvuIcm+ORiZCXB3h/8pnHdllI36cWfXNRWMN
X-Gm-Gg: AYBFou1qzlly8n6oqjeJQ6TQEA6M/tQ7EBdWJmrsNlpPdEG8LtGuL5NXvaNviqMfHOV
	97TVNIITkpNOM87QWm6YEZ7VHLN8zUx/xt9x8stFhjUFn2xEnMLBw5FLs9j9obDV0M6vfEoMImx
	Hz55gPxTda9naZhm+zPVjMgBnV+H0pZMQlepPUobGyeaGMvPCPrUHpKhHiAVD04UTqoqgeSiZoD
	dobZCF1U3sPzyt98f8ohuJG2SSwH2KebM42Dm6mv3qH0ylliHURNsAAzT9gFXd17rqDUb6p0hSr
	oy00muCG4jENe/En+A98aGjQPWkpFOhXKnCN/V4Xow/AlCuBO1F5lFTihCoWHSVLnrQjaUKB4IN
	YxXYnEFG9M1qDL3uIXUGxl4LFht42sJunTC+c3JfxjmHnPNfrRp2vPeLD9/IVHxrj7dvPjgSrhA
	7i/y2i4jJJDBtmVujsOFI1ZbzhDrNBYeNafUeuaznESE/4CrL5UXDtl87h7XdBoEkb5RwA5CKCU
	KYigDnq4Fgp8ql87q/PBMwfWHi6VBnZtkBwoiAThL2yp/PPbxapmoizk9Vb0bkD8mbF0mIGvdAq
	XOUauQJFjkzNhWDEknejzCTpjboRH6YVJQE1BEKs
X-Received: by 2002:a05:6000:40db:b0:48e:3d2:44b1 with SMTP id ffacd0b85a97d-49585ca3e5dmr5109174f8f.52.1794184452788;
        Sun, 08 Nov 2026 16:34:12 -0800 (PST)
Received: from [192.168.10.105] ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49592f39c8asm6541675f8f.7.2026.11.08.16.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 16:34:11 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
Date: Mon, 09 Nov 2026 00:33:21 +0000
Subject: [PATCH 09/17] dt-bindings: ufs: qcom,sc7180-ufshc: Add Halliday
 UFS
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
Message-Id: <20261109-halliday-dts-v1-9-289114ab8197@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794184395; l=1028;
 i=lightofmysoul@gmail.com; s=20261108; h=from:subject:message-id;
 bh=e5+pG0dDXEqC2bp77Ez+oDydvwUzWtL2BPwcLeGQJvE=;
 b=iWkySt37dA02PFmmfguFJEKrCwxdhGzWk24XOJRJESzAH3T4aPp1n4WJJawTbnHxhzVp2Ej2x
 6zP4CwoB/ABAxTrRpUZjqAEi2nTiW6DG09fAo8ednu84TwNnmQyJB1n
X-Developer-Key: i=lightofmysoul@gmail.com; a=ed25519;
 pk=jeRUlfmkhE53CJPoeIIXgu7rTE0ybDRH0HQrEwbydzg=

Document the UFS host controller on the Qualcomm Halliday SoC.

Signed-off-by: Stanislav Aleksandrov <lightofmysoul@gmail.com>
---
 Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml b/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml
index 3c407426d697..5d1784baddd7 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,sc7180-ufshc.yaml
@@ -15,6 +15,7 @@ select:
     compatible:
       contains:
         enum:
+          - qcom,halliday-ufshc
           - qcom,milos-ufshc
           - qcom,msm8998-ufshc
           - qcom,qcs8300-ufshc
@@ -40,6 +41,7 @@ properties:
           - const: qcom,ufshc
       - items:
           - enum:
+              - qcom,halliday-ufshc
               - qcom,milos-ufshc
               - qcom,msm8998-ufshc
               - qcom,qcs8300-ufshc

-- 
2.55.0

