Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D6672931F7
	for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 16:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789575022; cv=none; b=fp1n6iKldgIhqrQehVycBFYkuAgnCZYN7F9C92llR6RbFhHuv94m0DBwYX1rxs02u4vCt594qrzFIMQjmtX1U/ehjZvd0/dUEWdo6gxYVhZ7b94vGbg6MdVPbz98MeQdKHip83YtCNqD4kRdB96QjCz6oznowEicJF0VMeBUUoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789575022; c=relaxed/simple;
	bh=pcP+4eU1/beEFYbRmgIPFAGcmsIIEUp/fpCxORq8Ok0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDNO3TeGIKrV2KMZTKxJ/j+Idpo5zuLNOS1oAn1sH1E/4zOBOC89MJfH589Lq2cVabrslZbFrLnZPJb26pUlA/BnvFlvJ0i2ptu00wyCGex48JTsWgKRo2rm/+ymL7zlXnaXVp8xhkJ8c/ROMNxyBG4kQNfrnLDvUgjxcQ1Ip6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=dk1zYeP9; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="dk1zYeP9"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-93910a0cefaso90304885a.2
        for <iommu@lists.linux.dev>; Wed, 16 Sep 2026 09:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789575020; x=1790179820; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pcP+4eU1/beEFYbRmgIPFAGcmsIIEUp/fpCxORq8Ok0=;
        b=dk1zYeP9iXBwQ17LtDig4RU8KiI+1BJjMnJUeZiSqGdBCRoamcaEkZ9wscmyBFDief
         VfQDJsewsi6dCeBMXec21PxoGMI9K25UIrLzQQVJae/tKIl7CwLVxDhHuis2yYgbH3NG
         G1NK0R1jX9CiIFc1+CSWKejHdxSgdvskynleTaIwfP6rgQCbsFGj8/gapxuk7AkC2ynQ
         P8kOl50zrM4ZDFGF91t6h/zddNLbuMQnZtLkXoUYH3kr89sNnEhLFnvySHtLAQR5X4jS
         huqsq3wLPu0HyvLCZGF+rXpfM3nqbP6khbcplk7t/cup8TIkgDYh2/nIIKb3G8QUjSh0
         woMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789575020; x=1790179820;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pcP+4eU1/beEFYbRmgIPFAGcmsIIEUp/fpCxORq8Ok0=;
        b=LmSNaLXlB25nZmBu6rhCBCoGRVqV8cAiZ7vth36CjHnVPs7NCxz9plbd3nb2mInKRH
         cUMW/C9LKucC5Ip6eFTEkhASoVJ5JAuFFkS36u88np3C19p4BRfFU38FDypQwoPsepMN
         wPSqgwAspYQ32WS6sN6ENcVaXaYlCAwd8oGpEhRMgZGpz/NZJwSgtbtDHVvqpr1yIs5/
         so8zmU67AvX7+aK7EsN7EF23l6D5ug+kK+RuV6IXv+vqZ7Xe8PsXDXqToFiKNDAGzEIP
         eEKgvKjIZOvvbvWLJsNcD/zJSIw7paVxv+dQ22T00WBETTtpFbASgP03nmmcHsLJ6RFY
         dEoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzW1Dpm+f6tPH1ZEohSkhxUQ6Pj7xLnr0Ah2/+fB9nF3J+jvGD1O+3ym0OuiA8krP/884cCqw==@lists.linux.dev
X-Gm-Message-State: AFuF++mKBfUgaN5WVPoW4hhNuJzSMlnmnJH5Bxx/E9F2ILPDub+GsXSF
	AHoiM0yV9nO0E+THkvI8RMXiGLkeEK4DCL/IDVrtpagz2tjcHSN+JQqvnKYsltg0tiw=
X-Gm-Gg: AYBFou36bNMo9419kTdZDiAO88JmfdCeloVMIu3j6vYcIOrdygQp8VaLuhP9dVAt1Nh
	PELi4cHcI67lBUcjsE7pvZ/4HbDw2/I9JFKV8jlo5jwZBQ+meiCYKq0DJ75mxL8r10qjLp39Nrw
	gTa1jy/esV02KVAM85QD+NwdxCpvgJdemYlDnYtuEGTJR1TPAjrvyqTtUYzdTXIXbw1ne0eA7HH
	L7WhufbobeMJbtgcMN9xys4y7lpzeqnw/4m5RgTO6YgHJaYwk7sND7mg3WnpyZGpWnC08TMhld2
	EPZy8kkp/0vzER+etuxqsqhzw5O7aKPuOPLvI5dZ3MhY+dWc/JuQXREXDHuFQE3lviDpSum4mWv
	Z/f8AYAFZyLj6NMz+WZo7F7zgtUYGMQYHmzxHs8cyuMgLJKz4bP6e0h4278qq7EVLZfHj1zYrqV
	4qQhuSMjA6fHSZy+Z+LOHqVYdfviB931514esgHRhbNJWO3LkuWHJBpnb25t5GkW4AIYnXUWQkO
	EWGdNAI9ar90/kacsHmHylvWk3iq0WcC2f74lH/WeO4QzfmwiwRPVvTUw==
X-Received: by 2002:a05:620a:640b:b0:93a:344e:3d3d with SMTP id af79cd13be357-93bb7952c30mr495951685a.42.1789575019764;
        Wed, 16 Sep 2026 09:10:19 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93b81d19df1sm251902985a.45.2026.09.16.09.10.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:10:19 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x6sDC-00000009bqL-1M2P;
	Wed, 16 Sep 2026 13:10:18 -0300
Date: Wed, 16 Sep 2026 13:10:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Jean-Philippe Brucker <jpb@kernel.org>,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC 0/4] iommu/arm-smmu-v3: Support shared Stream IDs
Message-ID: <20260916161018.GE3196566@ziepe.ca>
References: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916-smmu-shared-sid-v1-0-517384504aee@nxp.com>

On Wed, Sep 16, 2026 at 11:12:33PM +0800, Peng Fan (OSS) wrote:
> Some SoCs have a limited number of IOMMU Stream IDs (SIDs) and
> hardware that inherently shares them. For example, the NXP i.MX95
> eDMA controller has 64 channels where each TX/RX pair is assigned
> a single SID by the hardware - the two channel devices are distinct
> from Linux's perspective but present the same SID to the SMMU.

Is that a reflection of poor DT modelling though?

Why must a TX/RX *PAIR* have two platform_devices nodes?

Fix it there and you don't need any of this? Or is there more?

Jason
