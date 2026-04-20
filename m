Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F15539F173
	for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 12:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776688838; cv=none; b=HCwDmkKCiI0M3zb9ot24RHm4lB1v+3Y87DL4neoMzU0iXoDEDyBf3xwgcuGJ3hNpXHgNpqYzXydjRIxrZDgT4Uz2gHKW8B8+hysMw3fn4V3nL3uJ5n8Z8F760oeqej9KhRA1cGqNpOI/wUVAL6QQo/My3CYS1Q6LcfO8eZ0z7kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776688838; c=relaxed/simple;
	bh=MpQEfPFZauRSR6Cbgz1wZrnHn1gDlI9cOlm+kknSO9o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DlOFV9VejTGccDUVTZ1gsUsWE3hyRW/mA2fztTiDysqSQcVcXws6WQ9sh1mVhn+ogILH7CaOkDwhKS5ZCYGb6IFfH239SB0jbbtjclcFo8cKjlKW6eHjaHq7V41pa7I5Zgje0Fcub0RbhvIVRabErxwaDQ1eiaYxTHqs/S3AlFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=bicrNLzC; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="bicrNLzC"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8d68bcf50fdso358272685a.2
        for <iommu@lists.linux.dev>; Mon, 20 Apr 2026 05:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1776688834; x=1777293634; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9++LeQrcwEH0Gt4SV/wFhWstBdymLBpMFcQFo0yngto=;
        b=bicrNLzC26zNjaxZpS5Lsl7tLjPMGm+lEI5W7Xf73/slEsN/LamPiBS8dnlVC2mLvJ
         wwedzjMwBh3yYaxBNDShAt9o81oukuzHSlEGY9pYAGYRbjD5AvUXDXj0FMkpMuTuuTRl
         v50b7mRbO0yqyPZ4m1JBI6irV6Ez9Db6m/erMRcPCBG7MNXTDNr8nGBRQ+D8c1SC2kP8
         KeBzkybTfj9SGt/E0RHgUD9hY95kDL8jpyQ0Hvxi7nteiUu/jwvSASaEHk4rfxJtVHSt
         YyDe/JkLvM8iPaEPbo+pqGY1ngHaIwksGC8JCblVJRVxVCY2oq0cheF7oIebzxDyYO2+
         vmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776688834; x=1777293634;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9++LeQrcwEH0Gt4SV/wFhWstBdymLBpMFcQFo0yngto=;
        b=KumaEGz6LJNqh2kxw4oLJ1c9O8SXtYQfx7b05NWbDzelF8WCkVBMiNua/80i26Sf9v
         OXCmD1g83fA/t+baRiDKmf56fvyi1ljduvbEEe/WEbBYDSOCUn3mS0rYZVQchFbejlwG
         7OlDs7klr8Pu1Gi1RKZME+OyomH1enQw2sStoAdYojGMXukuARE1G/ukILtgKIhOZvMm
         VAgNYnbFrPmRSodFH0XcojAPqDCsiRWzLXD6ce5Kbk/IVG8UFzfhXTDTu6rlgYkPsxBt
         UOf+HpmkDAHsp3jlf4XcL2h1EuS4KOor1KNhZqaoMPYZz7IAjqvzVC2fUiMvAXsaOnYH
         YqrA==
X-Forwarded-Encrypted: i=1; AFNElJ97Rv/83cvNZCxQpAte2KyfTaNamDBjkEm5jeMN3yYmnuJO9BASX8SNUmQrxGH/+HI9v6TEWg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxFUEP1c0Wlh8N13/QXrgThX2aAFQVeIJ1OGQvLItJz0ouOXJHi
	tpYdwEExJYey8iLSVM/aIpUwldU0WUKgT11FBgVEhDCrXmVyiXeqxA+tRixEYtgyFBU=
X-Gm-Gg: AeBDiesp6sryqzswJFaQFzHIteYPOjEzpnw+d4KePvIMyNgRjSlISbbFEuEdtG53fWg
	n7PU+u6BYmeGvVe8ThIJz3N5oC/VWrCgySVq330ClpXfQoBdDNksxLv2IOJc+dxmHtdbUweaWMQ
	6rC8g+PIknK2PmqcbYNB8wBhYbs6BCN+CpZXLlzE2gmtbmaansh4SpFdZu3wxN3MoUIDQxSpokW
	I07kf6mXBBCbHFf1c0D5Y2zVIwQc2Y+A5LWRMSB5btagel4T/4MDHYk4/o8QkDaI9HYx9YrFqGy
	vNEcgolPIcNSQ7EZ8olOdY6EXqgkUY78Gwwz9XjOYlkDR1zjc9kbNHNnBIOpEmX+wniU0mDAVzL
	LXrFV9Wntq5Rmivu4NW6SjotbnVvNvSASUTN2hNX55Ve08fHm6qa4URHNbOt+5g7SgZ03vzX6wj
	gAjecE/A83M/uBEKP+rmh1+ariV1Hy/+OBP4ULil/ea/UQOzA6jQyEex0tnabDEpsxtDd8gKGDX
	E+WaQZ8uWMjF9xc
X-Received: by 2002:a05:620a:489b:b0:8cf:d804:4569 with SMTP id af79cd13be357-8e7900157dbmr1922464985a.23.1776688834482;
        Mon, 20 Apr 2026 05:40:34 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ed54eb91a0sm52800285a.47.2026.04.20.05.40.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 05:40:33 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wEnvU-0000000CImY-0bzn;
	Mon, 20 Apr 2026 09:40:32 -0300
Date: Mon, 20 Apr 2026 09:40:32 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Evangelos Petrongonas <epetron@amazon.de>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Nicolin Chen <nicolinc@nvidia.com>,
	Pranjal Shrivastava <praan@google.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, nh-open-source@amazon.com,
	Zeev Zilberman <zeev@amazon.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Allow disabling Stage 1 translation
Message-ID: <20260420124032.GO2577880@ziepe.ca>
References: <20260420123221.20801-1-epetron@amazon.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420123221.20801-1-epetron@amazon.de>

On Mon, Apr 20, 2026 at 12:32:01PM +0000, Evangelos Petrongonas wrote:
> When the hardware advertises both Stage 1 and Stage 2 translation, the
> driver prefers Stage 1 for DMA domain allocation and only falls back to
> Stage 2 if Stage 1 is not supported.
> 
> Some configurations may want to force Stage 2 translation even when the
> hardware supports Stage 1. 

Why? You really need to explain why for a patch like this.

If there really is some HW issue I think it is more appropriate to get
an IORT flag or IDR detection that the HW has a problem.

Jason
