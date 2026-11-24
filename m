Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516788;
	b=cW+5AQICiPQdt7GnMvkFSzzHbYxHCuBPRyqfVLbJYGNnca0LU73z/1tbNJbx+bM7XBi5
	 Of7iXvKDOmeRctzmTMNn1P8EJDq+qBSk+LIaNpEELpcCWjBxwrnzFs+VANkMu1O7/Wfzs
	 KmXqO8pxdmlgROoZknrquNB7yhG1JYQmfQsQoEez8wpaaUID7HhIHR/qYnabTB+hU0Tf+
	 jTDvC/ljaJYOh3s+ql+yN4//9F22oxMtLBP4poyy8dyQZ104+sRbpP6HMviqZ4Ljcvjm9
	 gM0gLhdP926TN+BGV4BdS5I0RT/BfZRufQQeL80ZbmDI0fh6c3D6IVnDwLtUkfgSjuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516788;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
	b=Y+Eh5eFfG7m3lruLzmn1Bxs0BJQx2RSv+BQ3WVQyvsH5thU790ZikFfBW87f1wFmkhg2
	 Oo/LseD21QBfxE+v0B+/pv1e1MjTwyiMNvnRhqSeR0vBSKPJCcRrKCMdcz7R2eC38zhg6
	 o5yfFA1h4nXkL5GEZpHflzXGzot6Ly1TbpVt9EPyMXdHus8tv/PzRLDdjt5RkXLWDYLdU
	 c16gqqatYslCZLF+o05nmj0cqMNZd8E48Q5bEtkgMQ7bFTygMKynWhvPxFDBwFDbVDOO3
	 KXS4nyf74CYbyB0wM/ac+iuJIPfLrhOcy11QN3th3t4HWyne4SC9KpBp5N4Gwbzhigg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UZ9+oPrS;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F497606A321
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 10:39:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F497606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=UZ9+oPrS
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4bb6c7b6dbdso40110995e9.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 02:39:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795516786; x=1796121586; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
        b=UZ9+oPrSJcfNGBzobcMALgc8VsOsR6f3NOyyz7R8aeM1O5LqEUECb1sDT/sW6Dngxj
         xDrRNsswV9mun8b0Hq1X2uSD76iDs/m2kndJ9Jsd1PvRPzddD8wBPfe30Y7w658koU5V
         V7IM7TksAkt+lo/gr5mxGSGpG4eqXW/tzJ0qjGCy8gM1ekm3eL3uGgsI8FWp6sV/Rh4f
         H/rECsEvUe4+vVfIjDkyo6ywvIVgjMM1D1FrLf62Swwj3deJKMB5pkdH83K13K7nuMGT
         5UofYpQHVnmmVUCm73YzNfdHZlDiP6J/SHhfQnd3i4bJrN5Xg4zfSgLKKKJNRlEIkh1R
         JAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795516786; x=1796121586;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i67A04/jloiIm4Idm3ymNHqESyF+RQsVbnS4UKmnxA8=;
        b=JP6oOXiTFInNlhP8bGvbU/g/T1xWTnfGg6w/8XE9UGnOmd8dRIpdx0GZG1T3xcZ6bb
         md4O2iC3iPt/9bUy7rF8dTlxArmGAdwksHG9jFrutcQ2AkxpYcMHYtCeFnBfkbaxsgKF
         njDbg50rep7rNmkfi5xNTsxOvxt0Idy/+mogXTTWMMqZDi/2tO3dY4ou6/uJ1tKBaBgv
         g9RRAhvGlhA5rD36LwUiWFybgpsctd3DsCuAMxic/bPAjf7gPqQ5gaTy7JfGfryZxvPD
         mwE5uKpeSzCGA861iLZrzi/FtraKfN9Mjjpl1QU7SiUqEns+xLKC8C7G8oKE0CvSHfgQ
         dIUg==
X-Forwarded-Encrypted: i=1; AL+hErE78utglOJ3oA5OvtXY7lt3QfvxlB1wPaJhOMSn7+WOTorkZRsMmPPCJuVFSIoH3klzr4Rayw==@lists.linux.dev
X-Gm-Message-State: APuU4Z+lQ9nRxs9TDqXFANcUIFwi1FRO2CUF/aLv4Bn2NXuzB/QpHPLK
	IMT+CWy03IYsKpw4Ca3u4TijHtKyVOQ+I0nai0V1NMLqVIlynA170AUePStE9u44zp8=
X-Gm-Gg: AZFdTZfrkheaB77/vMW2WqyJU+HbbMdvh/nC8JLk405ALnG/EKgHWpLcFPeopxSfYku
	ssscCRuWgxUD5sYG7aFCD61efuUcZ9nWOYvzd7vqhPRvBgWr9DKY4OJtPxySMcnDcgONts30TXs
	ZwUCcFmvYh2Ke67459KBUj7r7DXAZyMVg1Fm1al/LHH276j2h0NSMpaq6f8F1c30WpHsNx6UEW0
	xDGUV+G8r5/5CFResqASnXR5kWpRz/AB5UHoBQFY/2SarDcTj5/hGVcZy8T5kROJd/i+s7IgnmM
	ZhkokNuV8zGYu3Rc+PMJEzWmJA9CgW1lrJeOTV0vuTDIi/xdF5vF6oPWRpYRSSqFXeywZsJYslv
	R8XyoVFnYas5JDqr3TcUgQr3uIEHRrRNqogq7IDZYrp+KV3fpD+MXH7se/H/ejOrwvXn7zU3jTW
	UrWz0CNS78rt2BFdjmd88Chc93j1TmRFrL89qMeh1CaxQFZshPw7zRvMCeQ1gtDvcOqbKUS28b/
	zbjQMsJan/KsSbVnYNqCySo3LNbCkFNRPe/xgqvcIPDoXpZAFVBZxt2XF3bwjrPHydmbaFWVB7b
	Gy9Jzm3brd9NlqG91lTIfaxz+6fcQf4mn+A2x5tWQf+WVfYMKOJmH0IYz0fWDia60w5v
X-Received: by 2002:a05:600c:64c8:b0:4bb:6848:d433 with SMTP id 5b1f17b1804b1-4bb8881d141mr281064655e9.26.1795516786433;
        Tue, 24 Nov 2026 02:39:46 -0800 (PST)
Received: from ?IPV6:2001:a61:132b:a401:6cb8:7c28:11e1:499? ([2001:a61:132b:a401:6cb8:7c28:11e1:499])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb8538b2c5sm425218335e9.5.2026.11.24.02.39.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 02:39:46 -0800 (PST)
Message-ID: <65749362-927a-492d-8bff-573c277fe456@suse.com>
Date: Tue, 24 Nov 2026 11:39:40 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/33] Bluetooth: btusb: Fix MediaTek ISO claim locking
To: Leon Romanovsky <leon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, Johan Hovold <johan@kernel.org>,
 Eric Dumazet <edumazet@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Pieter Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>,
 Chris Lu <chris.lu@mediatek.com>, Mans Rullgard <mans@mansr.com>,
 Alan Stern <stern@rowland.harvard.edu>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Andrew Morton <akpm@linux-foundation.org>,
 Cornelia Huck <cornelia.huck@de.ibm.com>, Andrew Morton <akpm@osdl.org>,
 Jeff Garzik <jeff@garzik.org>, "Rafael J. Wysocki"
 <rafael.j.wysocki@intel.com>, Bart Van Assche <bvanassche@acm.org>,
 Alexander Duyck <alexander.h.duyck@linux.intel.com>,
 Dan Williams <djbw@kernel.org>
Cc: linux-kernel@vger.kernel.org, driver-core@lists.linux.dev,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev, Alexey Kardashevskiy <aik@amd.com>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Greg Kroah-Hartman <gregkh@suse.de>, linux-sound@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>
References: <20261124-device-trust-core-v4-0-037eb0d17b1f@nvidia.com>
 <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
Content-Language: en-US
From: Oliver Neukum <oneukum@suse.com>
In-Reply-To: <20261124-device-trust-core-v4-2-037eb0d17b1f@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 24.11.26 10:43, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> MediaTek ISO claims are performed from HCI setup work outside USB probe.
> Locking only the interface does not protect the claim against teardown
> of the parent device. Unconditionally waiting for the parent lock can
> deadlock with disconnect while it drains the setup work.
Hi,

your patch raises a question. Can usb_claim_interface() ever be
used safely outside probe() without this kind of locking?
If the answer to that is negative, should the locking be integrated into
usbcore?

	Regards
		Oliver
