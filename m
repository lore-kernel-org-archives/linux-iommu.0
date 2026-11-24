Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542044;
	b=IL2YMnEC56FQPQ47ySlnBnMvUCqPUgl/xX7Oy5sdj3Xvxs4uElnVPvngOxNQTZAhDehO
	 MHQN028ELsZGiuAzPklr0iOvTGUYpvspsSDkqNzf9nwkz8wWMBBm++3O3PHezmk/QcV8P
	 OvyzCzk4YFF9J/Vv68f4x4tljAA65g0M//2crNxphZzo2YITHhsusVInT/j/meRKMikVm
	 OwVZVZT1KMaN8ZDXAiOla4HBl5MTQt/+qsdFocb6/TKNV1yv9XUGQXuOHHuPVgadFDq02
	 W7SU42Zv/6CpvsmVmXpnLYZPrr2nMhTB61lqWY7YYzZR66qCFXkEPGaii3PJ8WcjBTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542044;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=A0tfxpWQZksA+4DUx2Ik9FwTneKF6Ex273j07+ppekk=;
	b=k52wmakXDq5VBFmaj/p0xTvgj0vnDabdPl3HoRFPI2fCEL8k/3f8OT+WOh2Xsca4jQ3e
	 /G7DnKvRwM7LCpsPr58fX50j8VBoe8HVjDDq3Mk7EbsDlZ95TdoiSp1EjlJTppwyp3uTM
	 WAzm1U5kGn3473LoWmlz47is0xvROGsnRj56Wv3OGhz7NA8KBxQtuE+Mw5bu99n9z1UEk
	 EQ7Xc6HSAXyKtsd2mfIlU0YykAixJxKUfbezjs49R75d1zQHRevfPfozp7sTzbvQ0m/JL
	 OE338hDDyTRhy+n+wPmGGA+0eiaJNBLmtXH10rYONWGYoFw15omUcn26zOCraqtbmSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NPTM6bzP;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B4606A31E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 17:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA6B4606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=NPTM6bzP
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2f048bc09d7so212665ad.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 09:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795542043; x=1796146843; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=A0tfxpWQZksA+4DUx2Ik9FwTneKF6Ex273j07+ppekk=;
        b=NPTM6bzP+9KFd7Kn7KVs7gWXOwho4ee6t1vhR933A/8Yhf1SNo3a6xRcrtTJsJ1R7+
         0vUL9lH4bd+QQY0XAexGLpTUgQKH2Y5ook75IT+UXhzDiLJ8yhPtnfgs/UaiHZF9VZNz
         6uNA8cBag95l/nQlg9zvdACtyn5HBDwAagCI3TzkAHe/qrjr5ss3/sWjezjswMUj610z
         KHZ7AfMGtoTbppxw+EAU3E9ZcysDk+f/ZXpSC/sjx0gVQ/LhGkY8FlTkb7vanzJc8v87
         s2r2EA54l2xB1BSegA2Iw7k8UjGahUbfpC/OAvAdcKLvBCPR2WpIGeGmS9Rbspyo1X/J
         gl0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795542043; x=1796146843;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A0tfxpWQZksA+4DUx2Ik9FwTneKF6Ex273j07+ppekk=;
        b=OU7RsIwTm8TyrYMWei1WrRZfdb/qCbh/vTpNlNylheun/nCnO1bI3gap/6O+ZwYoB6
         f0Xfi9zIqynzoIX+YALO7Q7eqse6uhJh6w+5efHLDslSIg8lA15c/IsrUL2ekKWNJu8z
         ww8EZ5/btY1Kyfc9tMciiq3O+vzVwFjf6ohPvPwJ5/96sKJPoFlicLxRGdtQv5mSESfW
         HQ+ekSM++vZEwzKhdCShncKQaZt7G8/ARDtzrPHxrDqIgAJ547Ezz3ReB5NqMlHaf6To
         FzoVvi0o8ee2/zyjwc+w/kVifZJsvz2UelAQkipFOg+wnwmiKbPWgMRQR/bxvY50G31X
         ZI5g==
X-Forwarded-Encrypted: i=1; AL+hErH5sws0PgGYEYRZqwTx+1HZdx5ffkpE/YLKPmBWZ9XvuC0oop7QQdoYA/xUcTRu+1CJAdZJbQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z/bkbKnsj7x5TmFJb/7rqNBES2VT3Nr3+tvNNjGHXZOf0YuaFZs
	9TAqgcU84m/Xx9hpf4sQsZEeaTgQaH6GrLBoLS818lNjR6galb8RYcsK3RD6O2IRqA==
X-Gm-Gg: AZFdTZecxrxZpZLh0DjzxLBj5c3nG+oGKK1ChLBqFbH6qHmeI3TqIHxcyhXQnG2+HoY
	3cmn0cz32pBd7geRr8sfFZUxDstyXMyPjWNkkFbF3kPdEKAeMEHx8PTNi+ExyRjlOnTKxSHZfCr
	8aUZw53ZHgqn4FQnzU9Rsv3jIzihDnMKsq1FWc3oVGsgD5Kjae3jIst8EficITYiobz3TTgG+zx
	Soys2+v69Gzd0ISVwQglsWRG8SRr6b79jFw4Rm4oTVW3P6FWES4VaNUFnX9474+o1dIZaxFiIp0
	ivp192hqBLOQN6tcDPBl2aB/3czyytc46j9dajnILLZNaQpSLnL+7PoudjPpQQXZhJ509r7L8uF
	vy6U5xcYmsl4KYwhyz9qr39ho1h4j/C0rTDlFfpyPxKQQQzFhXwgBP7A/mMIg+IlANgBHhLKTkJ
	b+VXkbbZ9QIYMZO1eIMUxtCx9BrGZa6ZhCTuucLnD21t9lDyJPCfnrlxSVL6r6lEZz4ToC5gqeR
	tnamlQRoaN8UY5wPcvMlTMdDHfpfszLWZR1zln2w8e7roRUtXJQOKCE1rnZkcJet/A5OnmIwe37
	0XLhS+EUjSy3HX4ZOZYghx6tAxXixxhYNPnnV9epN0aPTyWu+9x0r1XbQqfIQJWgxV2ZeC1sKXH
	vbxSUDp2BJ6UctHN1XOGTU0aoy0xsZo1HcrY03wzVOLk=
X-Received: by 2002:a17:902:da4f:b0:2e5:9bdf:6b65 with SMTP id d9443c01a7336-2f0bce40277mr4837775ad.0.1795542042658;
        Tue, 24 Nov 2026 09:40:42 -0800 (PST)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cde6cfc6130sm7514061a12.7.2026.11.24.09.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 09:40:41 -0800 (PST)
Date: Tue, 24 Nov 2026 17:40:38 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Ankit Soni <Ankit.Soni@amd.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Pranjal Shrivastava <praan@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	John Starks <dev@jstarks.net>
Subject: Re: [PATCH v8 06/18] iommu: Implement device and IOMMU HW
 preservation
Message-ID: <awXMB5GaBlcv845A@google.com>
References: <20261123044949.3610702-1-skhawaja@google.com>
 <20261123044949.3610702-7-skhawaja@google.com>
 <i7i7msbox2idxet5xfzkf5zg2hoznnjpaivbpsjrpeoko445ys@trkpzp6zceqz>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <i7i7msbox2idxet5xfzkf5zg2hoznnjpaivbpsjrpeoko445ys@trkpzp6zceqz>

On Tue, Nov 24, 2026 at 04:29:25AM +0000, Ankit Soni wrote:
>On Mon, Nov 23, 2026 at 04:49:37AM +0000, Samiullah Khawaja wrote:
>> Add IOMMU ops to preserve/unpreserve the device state handled by the
>> IOMMU driver. This is IOMMU specific state of the device that needs to
>> be preserved for liveupdate. These ops can be implemented by the IOMMU
>> drivers that support preservation of devices that have their IOMMU
>> domains preserved. During device preservation the state of the
>> associated IOMMU is also preserved as dependency.
>>
>> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>
>Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

Thanks,
Sami
