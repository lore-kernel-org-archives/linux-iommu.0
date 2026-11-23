Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795468663;
	b=eSCMoyVP5ol50zg/Elg+M75up0Wwsvm0U5SnaKGWOIly0tU+oJoVUp90Fv5DRicmJ2w/
	 /D64lBs2PrZbX8kY1X21c+JkpPu5ClKyNlEc8Ugx49nGv/lUyWMEWnDMKrRb/9gzWv89F
	 ymdYIv3JorvYoaCr0vdQ57Cmtn0NcKwU0z2Gescff+QDtD+peqn9JZj4gZXkvSkkHBcdY
	 WALK7Am2DoJWXReEXtNlfzdoKBS0gqaCpWfbP0SAEJbPN6hv3m4bBvEDKaYS4XT8DJCIH
	 bQuBEBHuil1kmiLhmFJxgdGi1VyrGs1iq3jKLYU7mQVGpII2ril++f/Kope9Aer5Yyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795468663;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=mEI2MWJHKjiB6vj3bpQygFD6VsBJJyxeJ4zAlBvCIuE=;
	b=QRaa/LIEBzBVg+cJTetzRKb4UEEKzYPpbmXYT3PUR0EEtF5d9Nd4424jeqka/yU+If7I
	 bEYlNwqhpT3BqbsGozz12Vl7m6tbVU/h95lFWHl/j6+6RMUpOqbJmDz/ySlgeaiPxTFV+
	 2G1Id1boDMY+AhmKeUMHf0/z61x6HyZ+LejW8KE787+2XXdEv4B5gf5SLPInr9SrR2Zok
	 IGK5g8GwRJea4jisLCuL+iKnpkU8QRFphC+7VeiCgnuygmlQO9e4MtIHB2awo0hnlleb6
	 pEq+cKY0Bn8ayOWX5cAmIwRDqHb0/ADI/oD7vMmc1+goyZCRg6Us9DJ9p/CNmsfS8Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iOZ2uZQU;
	arc=none smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C289606A333
	for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 21:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C289606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iOZ2uZQU
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a9be758734so2317487f8f.1
        for <iommu@lists.linux.dev>; Mon, 23 Nov 2026 13:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795468662; x=1796073462; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mEI2MWJHKjiB6vj3bpQygFD6VsBJJyxeJ4zAlBvCIuE=;
        b=iOZ2uZQU3NMqPJTvAsBqrp038UyRtbixC5ZB+mWoPTljOKxb3Tvi80YB4lHITqFJJb
         WPgnC5Z1T9A5XoikqrkgAmRlgzo0Ehy5MNxYgBStw8E7CKZiEFOjd2k7Of+a2RvK8Mn3
         Bh+HqbYcgPHhbbeDh/khf386zDO/Ce2ohkAiRX9mTiU2V8UhC/7USms8sYCVy19/+A+6
         8xdGKBQGTOEuLgRpTm+PsmZzC6umT87Z32sCd0T5nnkWs7gczUMsGZ+ifQxoIvObdo8u
         MYxdlgqMOXAVUP/5Gicdq0NKwP/ZZITQ0TDlGtJFUhmUtViJQM6WB/YfMORIl3qAYeRY
         W/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795468662; x=1796073462;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mEI2MWJHKjiB6vj3bpQygFD6VsBJJyxeJ4zAlBvCIuE=;
        b=pJmM4UDVwJ5lqUFuBTrN5l06Ahsqq/OchYUlDpA9Crrc2t3LD7EDKBI5I+StMw9BTx
         rJAgrhZkMXd1aCwButc6DdbWyCXzBiabBW0NlDHI1SY5rKXMdV4Az7vwPJBpYLiQBduT
         N7E2RPjGTtSTPyPgVj1wiPcst/GArcLsr17RRznOmIX7uqGZr0t11SZ/DE9v45nsERKX
         bLMqA8GZpZR4Ptz2I7A/VSS+JVvSnqTM9PurOH04PJ1rHkUg21BvN+JX6ta2jhhKCT1g
         Pd6WhCCK0eGhoyQYi0HXWP15oAz8jwiMtFGymSj/FLpq7mlDlYyxTcjMI595EAfHWRdN
         kWhQ==
X-Forwarded-Encrypted: i=1; AL+hErG4YKIof89Yz7USp+a6ZooEtaj4jIAH1NuJQv5zktFK3vhWtuCJ+JhuxUJm/B10OhKVy5fg+g==@lists.linux.dev
X-Gm-Message-State: APuU4Z91qAgGJcpwBjRHPzE0pGNBepmPHqjyiqhnppV2os25HiXfvxG3
	J1yau/kqvKTvOPe1xRYWeCoaWeRVTok04rE9+ImPBocxjNBRWHE/MJi/
X-Gm-Gg: AZFdTZe1d1TRmqImrrjsXrrqj1nAu5QCijUguOaU6ONbK3+8uRZErQgcavtgi4w2iit
	PyFI2KNWkQI27vyNGST0FcyibViaS3q9GJL/1V7NVJP1KAagBYq6/2kph+74V/Vj/qV3xNnMW5O
	QIHu5dcQbGL68tv+2cLa7sptuDyGAUIvHME7KTxys+0gircEs/dv7jZGaRGXu5w2r9PylpM0ccA
	Eu/Mty/RwR6v09ubOnyAH7QboYQsgriFPVqkJ8+MHJBjEhvbCBgRqhqRvmdslsdb+rzNCeP3UAh
	zjpFm4+H83xase5/TbeZE4HgJo1yudQcMFxlCXyrzQpdHW2Gj2BLPUDbcdg04IegWNZK/E08i++
	NeEi74s23+hpna7v6WV6nyZjoVNdPi/b1qwuNIhErt2hoxT8jQ/e7N4VTzTOzKKnJB/Phco7feQ
	pNGQDAdfVu5LtaFAploEFzU7lvp+G8Rs/YTUYiVzJZniD0yntpvpBxQKJEyLyN6FoofgFgIeJPT
	SeNRNHYWygFqxXlBeLQHbx+nlMQWA3kJC5xIgesWqodIA+yru84+ZZ77Wqfk1tOXneP73Pdw7FD
	Vz8k5bSjbyijEJj3ZYdwLBM3eenO8Xux6h289dyKV9eYzMjW
X-Received: by 2002:a5d:4605:0:b0:4a4:14db:2348 with SMTP id ffacd0b85a97d-4abb29105d1mr18698069f8f.35.1795468661504;
        Mon, 23 Nov 2026 13:17:41 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2e6dsm24513121f8f.6.2026.11.23.13.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 13:17:40 -0800 (PST)
From: Stanislav Aleksandrov <lightofmysoul@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
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
	Ulf Hansson <ulfh@kernel.org>,
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
	linux-pm@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 13/16] dt-bindings: arm: qcom,ids: Add SoC ID for SXR2250P
Date: Mon, 23 Nov 2026 21:17:23 +0000
Message-ID: <20261123211723.1065310-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261123-pastel-barracuda-of-rain-bce8ac@quoll>
References: <20261116-halliday-dts-v2-0-2c92438c6c46@gmail.com> <20261116-halliday-dts-v2-13-2c92438c6c46@gmail.com> <20261123-pastel-barracuda-of-rain-bce8ac@quoll>
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

On Mon, Nov 23, 2026 at 01:09:26PM +0100, Krzysztof Kozlowski wrote:
> This should be rebased on my patch removing the IDs.

Thanks for review. I will rebase it, but I am not sure about
the order, could you please clarify?

1. Should I wait for sending v3 until your patch is applied?
or
2. Should I apply your patch locally and then send v3 based on it?
(but if something changes in your patch a v4 might be needed)

Best regards,
Stanislav
