Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CBF11C287
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="KCyHEfwF"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bd902f6b7aso143383b6e.2
        for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1705418969; x=1706023769; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iJ8kDv4NT77wbV/RUW9AhIRHKupbHjNRdeQr3Ppsnl0=;
        b=KCyHEfwFp6fSTGb+zPBty+qQaQXS46Hf1qvidewDxSEQydfbu5Hm6t0Aa9AMKx7/Kn
         woI42ijM+2VQWShAFnrMS9HoWQHI7KvpFY+ymNr8TTs3M/idvDjLK2Se12mlhFbB24K7
         BIeDHMwkMI9g4kQ6chHpl3ZLrlHIER99kkMQWcJrojQi+4wwZKBcVD4HXoxop0fERHPo
         AkBJOKw+bouBqZL513uWiVKEcGQ0q1oITHz0fbhzkYHyuo8o620P3NWK8I2AD0pPfLr/
         Vch3dzQm1ERG7ksx7JBHm6cYizf7xzksPwE6DaE/8SJ9GYmJupCe7uHpbRuZNKxknf4S
         gUqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705418969; x=1706023769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iJ8kDv4NT77wbV/RUW9AhIRHKupbHjNRdeQr3Ppsnl0=;
        b=Lj5zzKv8/Fxnw+7xhhZu4mYMc5MroG3jr7kQisQ+kQ7nSWJjeiDAyRnXBrS4I2mFej
         yDh7H63xwOMjjhPYMJEQLUXb9wQse/68JH1MAWB66zh0WglhGloHWTxdg0jvSsnroMU0
         Cq2x1QVXLbh0XwbifxhMS8YiiK6p/AznhwFeHAPQRi2vffRysjIhpQG8c3TLQOCxIMXH
         DSZvoEdSoFIjp5HxWVxnFOVfIZVe0lPJugIUH0/TgKIsIHQKUT9u4T/mCW5DBoMZQP4M
         /pRG0qyRq4zSTz2n+P7j71vs84DUVv2mcdJhGKbRAQ/kwmrbawUeBsrFLGMYFR58Z9ns
         k6nA==
X-Gm-Message-State: AOJu0YyBavU+oZkpLfQr9IlyjrYlQdVNHoYmihRGX+ZzOhCkBxm4fnnQ
	KE6NSS/LwYGgsOHORxmG4Fjd48jkb4vShg==
X-Google-Smtp-Source: AGHT+IGBWdHLHlu+WKmrXxmyfAaya9jZa+J4uJQ5YBat9EhQgRdlPfVABfpR7u3rUy/Ip3xt+opsKg==
X-Received: by 2002:a05:6808:2e91:b0:3bd:72dc:65a6 with SMTP id gt17-20020a0568082e9100b003bd72dc65a6mr3757509oib.58.1705418969400;
        Tue, 16 Jan 2024 07:29:29 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id q16-20020a05620a0c9000b007815844a295sm3800321qki.116.2024.01.16.07.29.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jan 2024 07:29:28 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rPlNY-0045nl-7f;
	Tue, 16 Jan 2024 11:29:28 -0400
Date: Tue, 16 Jan 2024 11:29:28 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kalle Valo <kvalo@kernel.org>, James Prestwood <prestwoj@gmail.com>,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev
Subject: Re: ath11k and vfio-pci support
Message-ID: <20240116152928.GF50608@ziepe.ca>
References: <df9fd970-5af3-468c-b1f1-18f91215cf44@gmail.com>
 <8734v4auc4.fsf@kernel.org>
 <e8878979-1f3f-4635-a716-9ac381c617d9@gmail.com>
 <285b84d0-229c-4c83-a7d6-4c3c23139597@quicinc.com>
 <4607fb37-8227-49a3-9e8c-10c9b117ec7b@gmail.com>
 <3d22a730-aee5-4f2a-9ddc-b4b5bd4d62fe@quicinc.com>
 <87il3w7zjh.fsf@kernel.org>
 <20240115104658.0b56bd35.alex.williamson@redhat.com>
 <543d9d2f-e132-4fdb-8454-68595cd20515@quicinc.com>
 <57d20bd812ccf8d1a5815ad41b5dcea3925d4fe1.camel@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57d20bd812ccf8d1a5815ad41b5dcea3925d4fe1.camel@infradead.org>

On Tue, Jan 16, 2024 at 11:41:19AM +0100, David Woodhouse wrote:

> If we had had this posted interrupt support from the beginning, perhaps
> we could have have a much simpler model — we just let the guest write
> its intended (v)CPU#/vector *directly* to the MSI table in the device,
> and let the IOMMU fix it up by having a table pointing to the
> appropriate set of vCPUs. But that isn't how it happened. The model we
> have is that the VMM has to *emulate* the config space and handle the
> interrupts as described above.

I do have a strong desire to rework things to be more like this, just
not time yet :)

We have enough real problems related to the fake interrupt data in
the guest.

This ath11k thing sounds more like IMS really - it makes zero sense
that a device would be designed where the MSI vector has to be copied
to another location - most likely the other location is another
interrupt source that can be programmed independently, with its own
irqchip, etc? Linux supports this now. Thomas and Intel did it to
support SIOV IMS.

Are you sure you have implemented your Linux driver correctly? :)

Of course IMS doesn't work in VMs, but that is a big motivation to fix
the irq organizing. At least you'd know why the device is broken :)

Jason

