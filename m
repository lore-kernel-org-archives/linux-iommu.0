Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794559041;
	b=C9nraN0OR0GbzcLhC4qIg7eVxTF4VxzHmxP1G7doL0ewwntb99czmRSQsGZNPHrtJabA
	 51/6PGnusUtOj1eNG8ijxS5Luv4YxswnzYzMg8119D8wmJo+hbvrSkDNluwapg51mpCcw
	 v/MguxtR7jdj+849QQN1kO0y4sCQozgEE+aeIUtRtnlgrD6er6vKiC5n4JT1nFy4cHg2N
	 tZWpg9xdqU0PNocKIGTCd1u0evsuZpQpEqsPa2nI9mGyHNYZQS06rpw0jLQ8r21hNhHTy
	 wqO6F4D3HOw8WMbxPwJEhnTQN56P+JxwvkGVjavfa1PkPXQsXOp+FYXXelGLkALCUPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794559041;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LGw1WVYMB7/uWOhnON2ZjpYzLsk6t5+hMJ8zM0UGs2g=;
	b=lkBcWw8lVhjU0RdLOyDos2uozz5R7qBeTLSpLuMugmokOX6qHPPbDi6XrK3zX8+02rir
	 axnIxLSUn92hfOjnOWS3Z8IoIFelB4q4/czPhl+L7eD8NZsfx5CLMXTa5rAupXJ+mDJoJ
	 EVLe2E6FsfYj+Dvg7hu9OwyZKrdrA+exOHaUxWixg1CChuXfBxRJ7RI0qsGyvPTaXK99U
	 w6BOQvkJQvURvnalx4mYVO81DxeOmTlQvagZ1bP5/VHCXH0onM4BeLb+qANwX+uHV3ZBQ
	 jOTXk+IcOjN97z5Tg3yNSynJpCixodNEIytvzRMBPNOcmtTLvDCE1JzvQy5zLarup7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IyOiBCuO;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2234606A88C
	for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 08:37:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2234606A88C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IyOiBCuO
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-89ecfdbe443so111957b3a.0
        for <iommu@lists.linux.dev>; Fri, 13 Nov 2026 00:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794559040; x=1795163840; darn=lists.linux.dev;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGw1WVYMB7/uWOhnON2ZjpYzLsk6t5+hMJ8zM0UGs2g=;
        b=IyOiBCuOvznI3F6JFsPiTj2he+js8kx+qh20qNmD+/oLptX1+7jtNZKcPhqCkx71Wb
         m1a3hrxEFao290PdIMNhII6RhTCM4b3bzVTp9d+DQBrqPyJoIvLY7AcgT/1meXgGzs7r
         9L7dr5cs0DjlW+FDvHxKNMIsX8LK0S67wvyIV4OmyAeqletFejwPKM3XgufC3fPYTCwC
         8t7fcKiGnO9LZaayD4+qqd/PVmuoEXpRTQoqT4d3kkfMt6Od/BZh9fajM4snzlIwAexu
         qUamJJEO4gaTQ45sQh0ildHAzIGdCEiX+Mx+rkyIJFkiG2zaZvEEL/bzwY4yK8x03NGa
         hQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794559040; x=1795163840;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LGw1WVYMB7/uWOhnON2ZjpYzLsk6t5+hMJ8zM0UGs2g=;
        b=K6NAigbkmYTfqEOMJSG237jFL7TWKX799VPJww+8s6LGdhW5D41srRfaysE/bJef0a
         LNn1BQThXwqGpzJwB5mTmh7UxTcROnC15CFig/2WRQ8x8wYRVYy0ySbuFALuFyBHN0s9
         Tqx9M1eFFzlZ4n6Bb508EKtUmyISAtzCBP3Q23hun3m4dVHNSoA7+qoKE5v9HZigh6p3
         5bitrISWqYkHS/+kcDyyw46cd6Ls2NxBxt9ejyAvipqmpvOC3LWc0EQRycPllHzrMm9/
         iTbZi4lVug5y7v8/hxAupnF2xSvaK2mISBsIO03wD/mdR73gFT/v0uwfLwhieST3k6KG
         8gCA==
X-Gm-Message-State: APuU4Z8d91D7ojWx/glC/OqH/xQow2WfalaoIL5EZLbML7JJSg9L++nR
	f8pHdd5fIuI6A+9sm/EtnCIuWwgXx/zyyPDdDUzkzTI8p/W7GXzzdD8z
X-Gm-Gg: AYBFou3Hpwu3xj0Pl5OWaYAD96eQXCgVrMCIKWrTBUijoDtToYXo9b8wD7uhR31BqI5
	K91/I5Q64zRW/bIP1Kyc96fwe0Z6X89rxCedCToJm0IrvXGjjvK20MKzJdM0a1kMxIp6mG/K3OV
	sTAjE3s215YH1+Crf5ufU1a+OOx/mLObUunY0p2DlqfnWloqjaDHCv7AUR/G88CDaGktubXLf4C
	b/y3BcK+lOwqmhJu7gRs99CV/ncTf7udFBgWMkN2FXBlRn2NxO6xjLb48JkYnDnlMX4coXzjegJ
	By6s5GOo7AkLkiRW8s7/tz7ykr5c0kHDn8Qn4vpOZEAhMz0jVjo5Ny+lWnNk8RQZK+R7jVW5uvs
	V67tjNxZT6b92qxcG0AY9lXMFpi2NA/c4V/ASLe7RHMmMX/HQH6DTIEhRtNsTUBUhlIFwW6IJBo
	Ku++x9QBST9y8X1O3DFH3a0P5U1TGMLeSkepJquaPUIhhD+1w0ae0/yi+WMoZY0GDY+Sbzx0xC/
	bRUotSlvBXNLJJqJmmY1deTsgbxj3ofOEGOQg94VUmkrB0VEOzwDVgVvKkmLcVUJFEb2/jAL8f+
	tNG6zU2ybWyV4xdZluG8uKcjJoOnQWgbzu3bER2dof4DYvPlx6gYkcU4Jz2OsCoFJ/x1w3feKls
	rA1E0XamQe1hxbga6gLwftowLW9c=
X-Received: by 2002:a05:6a20:eec8:10b0:3e2:2228:c62c with SMTP id adf61e73a8af0-3f7a74c090bmr1701640637.2.1794559040122;
        Fri, 13 Nov 2026 00:37:20 -0800 (PST)
Received: from claudebox.iyengar.cloud ([50.39.139.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8bed1a6db53sm747372b3a.21.2026.11.13.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 00:37:19 -0800 (PST)
From: Arun Iyengar <aiyengar1990@gmail.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh <smostafa@google.com>,
 Nicolin Chen <nicolinc@nvidia.com>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH v11 00/16] iommu/arm-smmu-v3: Implement Runtime/System Sleep ops
In-Reply-To: <20260929034510.2023173-1-praan@google.com>
References: <20260929034510.2023173-1-praan@google.com>
Date: Fri, 13 Nov 2026 08:37:18 +0000
Message-ID: <179455903885.2418534.14656921897583011972@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0

Hi Pranjal,

Tested the system sleep ops on RK3588 (Orange Pi 5), MMU600_PHP, no
power domain in DT, with USB3 and GMAC translated:
- s2idle x3: OK.
- deep suspend x3: the SMMU loses its state (CR0, GBPA, STRTAB_BASE
  read 0 at resume); your resume path restores it, USB3 and Ethernet
  work, no errors. Without it the SMMU would resume in bypass.

Not tested: runtime PM, MSI restore, CMDQV.

Tested-by: Arun Iyengar <aiyengar1990@gmail.com> # RK3588, system sleep

Arun
