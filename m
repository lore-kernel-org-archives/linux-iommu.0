Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794691849;
	b=dlykd0UE7FIY6LawmsnJZC8NJ9auGORqt5BhaQMWeAc6uOh7CQ+Avcp4VCL9uG2jDpHk
	 PLB+dAgf6N0ppl++Gv25bTG55ZQvPE83T2k6HYmUU1W7eaKup3gPZ2UYh20P+qXOiQvi/
	 8QgtZrQUdbmuH4PDA7Jk9aT9pdae81Na38gu14wUWQur8fps72AFRu0sfVGM2Oyj1CdIN
	 mUWiSsN4a+yo8prk0qx97PmxalgbPsyoZDFsZwRObkzWZX7vknDQPHyZ2LjBB/Ra0T8Ti
	 WeZGH0kIDH/SrD/TWm4xOnMMX28CZaN9eTE/VX7L0Pbygni19o8luPZ8R9dIOK0KjxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794691849;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=vju4Tmf9HxWLCGDozxlRYY/dKPR1MEju5ORsVHds9AY=;
	b=0G0/eaVc7vNTaSlMTFYvMvuTHQdXo8kOh/YafHzAW2zMEOZAz+HxTpntvTx8kGq6aBl1
	 y9ljBEyhElDLWpRAqv1l4I60+vv5bkMhhD4FTGdBf6gUhkmuYp6nJ7Vtn6huVoyn5aS9Y
	 UQc0IJHnvuvh2ik3RsToduHWeHIKGu1k4/Ta9mhdHrL2dtwmFzkIjacZfxTewLUjsmRF6
	 /ekTdenSmyU5prNUWPcSWIxbGLCpUGW/AdU5oCaH8Bk0X5fEKJIk75Wbqm1//vVA9QaMt
	 Ay1ai7EpLIBO1blzJ5bRQOfnN0DwBoXrHokO6G1ZdTcf5Yh89SJNTc80Qjdc0IKhplQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oe4whgMm;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E1606A327
	for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 21:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD6E1606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Oe4whgMm
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a9a8d6cea8so22067755e9.1
        for <iommu@lists.linux.dev>; Sat, 14 Nov 2026 13:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794691847; x=1795296647; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vju4Tmf9HxWLCGDozxlRYY/dKPR1MEju5ORsVHds9AY=;
        b=Oe4whgMmIY7AJRUl/ZLStdHdfHu1DWj1T8uzBmd5CjeOcdGHkga3g03aJIkfbFQwIw
         j3b78I69Po3AdHpiDlhrTj4RfJJ9Tn+sn0jc404/3yUgZWa+XzwViJMT6apDaadBH5fC
         fMCmJ6VR04Rji3X3qYT/UiIvVfDu5p2HMuHILU2wQ9RShXcOIyv+7EtirVRcgRy0Y/zJ
         XxsXMZa9VvN2NH4i6Pf3zKqBCo3d0t67qlPWBE+RbzLophuBUeL412RwkM/IOs/QMUdJ
         JATTvon2p6IXdslRWSOiR89aDvr7035up083oZuw0EBEpYZYb0f7RoMzjmiTGIoJa1f/
         csWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794691847; x=1795296647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vju4Tmf9HxWLCGDozxlRYY/dKPR1MEju5ORsVHds9AY=;
        b=SJSVwrxB/bTKzmwqKg49Z1MpkDyvjZogMz/8b2GxpkuqFG/HeRik07cRWqmYZPYHXl
         0AQTqQiKK97k61iEmk9WvLyFckO5hfuVwuC4xysJeu4t32CwUeEGP8uj3ef+8zOfa/DG
         LVH859JLUTecoRd7d0bsmNxGk2Ho+IfwmV+qZvJOUxK1b7jjsktwkLJESXGTjyjMpKH/
         RJY1hJHhF2t9dYqinnVBtQcoE7sxvhoTIVHHX9Ghbndfi2rSoNmsGoj5gmhKB4GZuhdm
         PUUBUy5LtvD3IJrgyWnvpc0AUeXN0jqcHGFFeIKA0xt5m3rULFyqh9Nr4+h45s1ymzpP
         Qlgg==
X-Forwarded-Encrypted: i=1; AL+hErGArCl+2ofcdH9uveeIOtotjCzgNt9uiCVMZ0CggfbIRBzm3FoXRgNWrhWRdoPwPzR/6Jjwwg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8S2lspT8y812TYvlmvSLmYsFeD1yKmXGNi33u6TFbpJuovxCG1
	VHw1wrzVRHeNbpa1VrNKYjtytBFQ+ejDPUiAeub2A193SvrF9St81l1N
X-Gm-Gg: AYBFou1IBdufX7PPVuwbFRNXg7ax/wHyYGIylYjXGrj/KDQDzQvszZB9AtbzPuXLngZ
	YNTxNc366zrflcxHWsIC1s1w+/mkSXlbWRfu1rKqb4sKW/CBZs17x3KqVq3u4k2weGaRDQ3Buzk
	jO8S7ohGpj+nNA/L5+agGqIsDg4Xx1dOZkesbkd4jjN3uY9o3YkhODHo3RN+o6jR/PJqEwzEGKo
	M1YVX3GVr11IO732QPXxEAqMaPUAdR3Lpko+fdrbi1xNjxIm0QfntiW1eFMHYlrw2b4Z08qM5Yg
	xlYyF9yhtEMf+lVAFm5MYE62b2ao3CzaCkFvsCgQov9lkWWmMW0vrPgix9xCdPUOSyOBYKzPfvi
	KTkTZs04M8tSaSKq9CTwbpm3Od0QJXp80nYQvzbg3+WA3boUzrOcAoJ+L20EEd8nomaAM3jq35D
	NbcgsGWyCTMwEeX52HSSeuuSBs0+ZUZ2g0B68tA/3jetUZWP49w9Pbuh+5TnHum8lpVm1ueVMIq
	p7KGYoh4n1AwRg3imFjWcMkF2bQ9qOFzD9IXMr32+j3SbBy4OWD85maruGdmC3J9vTZTnUEGUc2
	OQgxxMyr4evcd3epZG4rQ0XZJEk=
X-Received: by 2002:a05:600c:2784:b0:4a1:d49e:9ce with SMTP id 5b1f17b1804b1-4bb4e2918b1mr187322445e9.2.1794691847097;
        Sat, 14 Nov 2026 13:30:47 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4e2esm12803478f8f.36.2026.11.14.13.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 13:30:46 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Abel Vesa <abelvesa@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Robert Marko <robimarko@gmail.com>,
	Guru Das Srinagesh <linux@gurudas.dev>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Lee Jones <lee@kernel.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Wesley Cheng <wesley.cheng@oss.qualcomm.com>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Bean Huo <beanhuo@micron.com>,
	Stanley Jhu <stanleyjhu@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Amit Kucheria <amitk@kernel.org>,
	Thara Gopinath <thara.gopinath@gmail.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Georgi Djakov <djakov@kernel.org>,
	Sibi Sankar <sibi.sankar@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-usb@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-pm@vger.kernel.org
Subject: Re: [PATCH 16/17] arm64: dts: qcom: Add initial Halliday dtsi
Date: Sat, 14 Nov 2026 21:30:28 +0000
Message-ID: <20261114213028.1933448-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <0cac5090-a135-4a6c-8221-846b34ed5513@oss.qualcomm.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com> <20261109-halliday-dts-v1-16-289114ab8197@gmail.com> <0cac5090-a135-4a6c-8221-846b34ed5513@oss.qualcomm.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 13/11/2026 13:10, Konrad Dybcio wrote:
> Please add the other idle states (D4 and E3) from the downstream
> devicetree and match the order of properties (psci-suspend param)
> to glymur.dtsi

Thanks for the review. D4 and E3 are already there, as cluster_sleep_0
(0x41000044) and cluster_sleep_1 (0x4100c344) in domain-idle-states,
just above idle-states. In v2 I'll move that node below idle-states and
order the properties like glymur.dtsi.

> Please use '0x0' for zeroes in reg values

> Let's break up such long lists into one-a-line

I'll fix both in v2.

Best regards,
Stanislav
