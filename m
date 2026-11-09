Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243864;
	b=QWM71+UVtjvm8GR2fzYu+Zc37aC2dGo76Dt4+ctewhQBJ0njGzVUOdcPAVlCFaowwSx3
	 Ita7WHhjXrWW4ubXPjFiFFid9rBkbSyKyIpUgfstWMyTLtuyH0Sfn+wqLTKOfzB4FgEhh
	 eKhb6RGy2G5GKFKt6Al5hW3VO6Se+OBJ+2SCWm49BmpMRC/JRqAXPBDSGc8qJtnaroxmI
	 zsfX+rPWXwf85yghT1sbT1G6/keh7Wu0TqV05lIYkBI8ymXfhoJzja273xUKXi9qrFWxr
	 J8s/2KqAvzyMgA2fTBSjMpyd5Bl56WwTBMa5n0C8//Qq0UhZqiv0VCaYf2cUAN/BaaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243864;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VmhgsZdfI41q6bSk6Ws0aoyQukpnInOpVRPvZF0DgoY=;
	b=rLM9MI6vpr9Xsi2BPjHrgbXsvbND/YpP4YvMzIDjxEBtrtOs+4vQG92lJvaBpQBNZv2q
	 hV71HetCyEVkCziBSHJqOF8Z2B1JZoEPXhc0AVPIa0lStUyDnh8JajMiM0tAqRFAGbCSM
	 DbdQ/hBMmTrLIQPSr4AXOy5ZHhRv6oBjScAUep1bY2eYgegN+VY3U3NnAi65MIOheoE7E
	 InGXgLwyFK6b9+5juD1C7xKA2l2/V+2myEr68EIP/uf7LX7QdoDyuywfB8/5UyDirk3qZ
	 ToQg7Ehq/hGpqsf0z/rfXu4oMPQQoP2QaXGc7F5iGTVrl/spgmRk63jkcm79EYjmauQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXpWUKRa;
	arc=none smtp.remote-ip=209.85.208.48
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F2EC606A333
	for <iommu@lists.linux.dev>; Mon,  9 Nov 2026 17:04:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F2EC606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zXpWUKRa
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6ae305e3bd9so1831276a12.0
        for <iommu@lists.linux.dev>; Mon, 09 Nov 2026 09:04:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243863; x=1794848663; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VmhgsZdfI41q6bSk6Ws0aoyQukpnInOpVRPvZF0DgoY=;
        b=zXpWUKRaZ5RHwLVn/nBZlOQhH3l9x1eOSHy+rovAsokMcDCMohfzdsfC9XICTYei7v
         bvIgniVENgFdfd5S1jRdhIhZWkf1V3KiMeP7u/3BizQLOOQ4ZOwx1lJxZCntjrW9BoBv
         ALBh2EJZEiXo1w1Q7FMlTL26QX+7+lG1RLB621MYIObzgNM8lqRl+YwT6RpfPUpXTAkL
         I74OlcVMS6uEFsJV19O3vXvhIC7WORZvpMzDCGFCygBq+13s+BuecxPhPd6bQLpRfqxI
         JJPCwwSBEZ1w3PT9DnR2GmFCrWDoxdMvmnXhU4equ4hyG1hwrs6geu/wFbIRh7G50PZu
         7YzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243863; x=1794848663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VmhgsZdfI41q6bSk6Ws0aoyQukpnInOpVRPvZF0DgoY=;
        b=r647/Swysz0N2iFTR6VD7qnMs7rKgpg6FCxU7Ds7kzuBhfMvifttC2K2fIbgzAdfpn
         t+9/pdt7lRZ6lPq+MU47piYIpK3+IefNcynYs99yZfoMZKaljoCHa9oC3yfGLPojrCXT
         SHrNLJo4TJxKvzGNBojnY23AnEC6NVhEB3EQBR3QnzEpNnA20ymln0Vj3w6O88XJSfVz
         q0J29NqwFvlt+Zl1AjgxModcU65+V9mTmFfyZEWK5vzGJIm6xSs8Fblg88L0l0/4/Hlc
         p8VgSF5dtLrhGO3byB+oS+VNWNsux52/Cula6zP9+wn+NCYMnzPdGeqr0VHN+ABSsnfv
         L54A==
X-Forwarded-Encrypted: i=1; AL+hErG+nkJRPC739RbBYFSn7tWcbo0hBbh/Sr5rx0XDuqY1MQRQd2kJGcc764iOe/Lk8V68hfgCMA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+Uwlg3tgSoxmKeCGIHRz4hAMqbQrc+ZVeSR0BXRo+lc+XEZ6wx
	9ApeA3vS0Rj91p3PIkJwp0GDihAecuBenWxpilSQBWmdZUIRA5U6O2Cz
X-Gm-Gg: AYBFou1/NJljYBND1j88mezMM1ogLWsfeyOQS/ylBJBcHvyvQ877wYp4hTG+IF9ztcD
	HMi85JPJaLjA5xZhZ8HeL8XMyd8I6dktvdwTG7m2aI0G/xpbwla5B7faezOXJW4AjwzQGKCCkJy
	lL/Lfu2etnUspNdqWbVXI6FCzj2qDaC1OPqrESleQqqEDMUdbB6rAMHnnZKWOCCgkRsXA2XMazI
	m0AvNA6o9dCBaB8cui/ug1ZP/ixubvT1J8r4GySRvMFzMBiavxTOlIdQnUGg3i0M+3lZ6G8dXQ6
	sTklB09D8nXI67dditdEQO+GKUJaBXYyPYA3L6itHsudu5bvhnO8BLl9sb2bUsaYGOxTwfDWA33
	s1YqQdwCj1+p0QcLWZO3dO1h5efUG0UwCrTfxu7Nn5soY+7G9lXMj/2Dz2HBK0dKlFy9OW4Clbj
	90VkNSQMCnPsy4et1fL9UhgORuAjF/XYt84JFeN8fKhsChC/ly3/dnqenizApWtf0FhS8iTcJmr
	bz67IGsDycqEB8flBgfAmDD9KkHRzyld0tt35JXP96vuCaeyI/o6N3be5ZRa+FGi4lcr9ZGfXGh
	tZM1/dvmoX2R4MYO9vK5Q+CRqjc=
X-Received: by 2002:a05:6402:2356:b0:6b5:7792:d82c with SMTP id 4fb4d7f45d1cf-6b756ad7482mr185305a12.16.1794243862514;
        Mon, 09 Nov 2026 09:04:22 -0800 (PST)
Received: from flare5 ([212.58.121.92])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b721ebe31csm1878937a12.16.2026.11.09.09.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 09:04:21 -0800 (PST)
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
Subject: Re: [PATCH 17/17] arm64: dts: qcom: Add Samsung Galaxy XR
Date: Mon,  9 Nov 2026 17:04:07 +0000
Message-ID: <20261109170407.2073295-1-lightofmysoul@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <3ddaacfd-59c0-4d87-9b8c-2caa85143393@oss.qualcomm.com>
References: <20261109-halliday-dts-v1-0-289114ab8197@gmail.com> <20261109-halliday-dts-v1-17-289114ab8197@gmail.com> <3ddaacfd-59c0-4d87-9b8c-2caa85143393@oss.qualcomm.com>
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

On 09/11/2026 16:12, Konrad Dybcio wrote:
> On 11/9/26 1:33 AM, Stanislav Aleksandrov wrote:
>> +&usb_1 {
>> +	dr_mode = "peripheral";
>> +	maximum-speed = "high-speed";
>> +	qcom,select-utmi-as-pipe-clk;
>
> Is there no superspeed / dp altmode in hardware?

The headset supports USB SuperSpeed and DisplayPort via its USB Type-C
port, I just haven't brought them up yet. It seems we need a new driver
for the Type-C controller.

Stanislav
