Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722D01A00F3
	for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723652363; cv=none; b=aFqJ+Kxjz2her9aq65Awf1T9O1So05PL/1QHMw75oO/vxrWhmvUxnxttbn1hMK5/+pe98upWABQ5Ngtx3uHmq5yk2Xk8XJGMyL0Rqp6i2YA8sBpWKEmQNg0n3Cj4XVIs3uZySiE5UKWt2joAHOvden93JPlnDr0ZtZCYiQUQjQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723652363; c=relaxed/simple;
	bh=OwGhmYU9SpdjEP/Qg74+ZT0vmXSL65coCmc5E0UHD9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Zh0OQECaXf1hLrM6Bk3twpB3gKr22QBYIVgsOubGPgxjO3YdUVRSO22aG2XIIMnY4nwsUL6iyghFkyXcICaa3+GouLU9ageP5NRKrlADMI2rFOpfah/bV4EWUbStyvXDpXiuSq/1JJaB1ZBsgqzQ7cN8lalx+8kFoF6hAfuU7Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q5jVEtw3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q5jVEtw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723652360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sKjhEHT5Khyzus+b/pzSGTlNSXgqg5g7ApvnqngqfJo=;
	b=Q5jVEtw3o7jGERQs/7q7NVk0SF72kJJwnEdD2PNMak4dvc7lIEOZEyI4+XdjdAlpmtfDHz
	JR+uoCjlXCoGRkVmkN+ERBQq7AhyiBF0aQulNljPVgoTnL+Lg0e71E7x+CDS8CvDATXEu0
	lNWFpul7hrdGBeRQs2JVHk4Yeg0zQpM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-b_04BdHXMQKFFMaB8nPv6Q-1; Wed, 14 Aug 2024 12:19:19 -0400
X-MC-Unique: b_04BdHXMQKFFMaB8nPv6Q-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6bf6a0c2f1eso4628516d6.3
        for <iommu@lists.linux.dev>; Wed, 14 Aug 2024 09:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723652358; x=1724257158;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKjhEHT5Khyzus+b/pzSGTlNSXgqg5g7ApvnqngqfJo=;
        b=MrVKMUO3Wz7ZYhwqgEC+ZIkl2d7u+K4NMub6utRHeDTF/e+rQ5ZD8pHUdasfeLobpi
         Vcho1DghXZRzgVUydZCco9Nj7iL78xblbJXesEfBn44x5AHDsOgdcRtb6FDKGNuprGOK
         zVSzyfRWY9rYEeXXNAn7myR6Vl4X8OQf4bqcBAeySIY5ZLKBbAnjTPod1Sn/x7tk+Yb9
         qSzJwQA/+zl6a//uyfzsyd3DmOAZ0vkut+xfq17x913t84fYtNVi1Ofjvu63pm2wNBI0
         BKVEeTM8CJ0iIm1yUiKlOQhb2IPc2Gpx9DbhmJyl/molxykkZFNV0q7xHPax/8o1aL7s
         r5Iw==
X-Forwarded-Encrypted: i=1; AJvYcCV7lHwrUyhFf+a/KsWN6APnFaKHJgEgjTQlu8/49+Sj8QnpWoW+4O7b5YxC9Byz2ctxpLu5rVOOI2trqUMps3kA7DuAI/I=
X-Gm-Message-State: AOJu0Yz4lInx80O7cfiBY5/5nHGLwwKNHfsctTH0Ya2jAPErwkH6jM0x
	uEbW/98TIHWxf73NyM4bKnYhBH1Lmk8FtcPvqFbSLMVoqgvfFbM5AAgiAZfFlyYBc6otu2gNr0n
	49tUaC0oqvTeGb9eUsZLOd6SRCzmAWeLob1s02x0yOWXJBSkFTfX6
X-Received: by 2002:a05:6214:5c01:b0:6b2:bdcc:f45b with SMTP id 6a1803df08f44-6bf5d26aa76mr29082716d6.47.1723652358512;
        Wed, 14 Aug 2024 09:19:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEt9hHbhI3xO/6YOemajUbtX/MgNEDnatt18EPskyAe5F9AR4KMUR9C9UJlEn1m9ge+IrtqvA==
X-Received: by 2002:a05:6214:5c01:b0:6b2:bdcc:f45b with SMTP id 6a1803df08f44-6bf5d26aa76mr29082496d6.47.1723652358093;
        Wed, 14 Aug 2024 09:19:18 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bf6a7a8c02sm2632526d6.10.2024.08.14.09.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 09:19:17 -0700 (PDT)
Date: Wed, 14 Aug 2024 09:19:16 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/7] iommu/vt-d: Factor out helpers from
 domain_context_mapping_one()
Message-ID: <ubyjtqgr3seyd6w7oafei2g7illhxqwfpbfms7gyymt7sc7qup@zqutbrqunwxq>
References: <20240806023941.93454-1-baolu.lu@linux.intel.com>
 <20240806023941.93454-6-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240806023941.93454-6-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 06, 2024 at 10:39:39AM GMT, Lu Baolu wrote:
> Extract common code from domain_context_mapping_one() into new helpers,
> making it reusable by other functions such as the upcoming identity domain
> implementation. No intentional functional changes.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

