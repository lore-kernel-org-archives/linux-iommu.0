Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF03984A2B
	for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740575067; cv=none; b=V3Sku4xtVouq8KhlQQ5XSy5f0Vueaj5IZ3WkZp8DDLVw1PBp2/rnh3SbOvpYFAMUw6vvfjICw5jaWipDqc9dLdAiCGJ7XjDqIRNv3BUrEG5OFcsHsQr+g1FRVKBY8YOR6XGpCafwd1mu2EzspfVhfXhWhrs0Z3m3N67xlDuH6dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740575067; c=relaxed/simple;
	bh=D5ZlC5M0pfwNbiqQwR8fbHoOjPuQ/ClIFXStOmgzmDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tR+CVS9vfqbPreI+jHf8N377EL8Qol31zRoLHTZWKEa+1cXUIWE0wc41JkWeCIBG+gF39uD3yGBsRxykouh7uHXX55BtC4HG+b3EiRK7jg3YP3rCr1ewJxcn1pS6IsPuf7ORc6bFZbUNPjBNdCDfZ5ssf+3UhhKmowYOT9+FWUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=F9gHOAI2; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="F9gHOAI2"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-6e889e77249so4411956d6.1
        for <iommu@lists.linux.dev>; Wed, 26 Feb 2025 05:04:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1740575064; x=1741179864; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D5ZlC5M0pfwNbiqQwR8fbHoOjPuQ/ClIFXStOmgzmDU=;
        b=F9gHOAI2N3Ud62YEFVZkctKGNde4/45dGSbHVZiaISU/Vyv71NudTkh9X9AJokMPn2
         wJ9xfUgekf871mEjNXdGo1ejVyCnIeH7WAzOpw5k416xUcNR9Xk9SYTdPcq20ntopB2n
         qQtpjbDrSShikboiYzWqGCJAwB3dLoiMCNbG+uiSbRoJtAPDOKzQFUfRoPVFF6uBTAiz
         pOhufueu1oSqfy4+zLWkPkx+eINeTac2/SqEkW8bDqk4IjhXiu5EmhJKbncZlxElZ1mn
         fVxRdCuRKXt77d3LEP7ru8LgglF/DG8WkSa/1PceC3V++KM5KO31E8ojMR+Xn8++WdLE
         907A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740575064; x=1741179864;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D5ZlC5M0pfwNbiqQwR8fbHoOjPuQ/ClIFXStOmgzmDU=;
        b=X3fVW5IMR3XxB0HD2Kd3suBd2upxiP9j1fTV/+menHQR7pXwt8KR150e55byyub/vv
         iGwi7hw4xoueHd0/QDJPqzhx1k+sOnhiimdvYSLi3oxaL6nGlpQk6diQIAp/6utfS+mR
         5yT/Bm+uLYL1j6XyUAvacfm91fnzkw/ooyGvASk2mt4+PwZvgWHZ9N7G+AYUTfRc5CGk
         fsDfvwak51GSBZ/oDfulfWO//NsHJbId1K8ScXhEhT+DEqtKeehqMIUCRGmkkALX4GaB
         JZ4EXhvJ3nsrdfiPkpb9xbzZcmHZsb21Er6tMK9kLspW0GYQIQNRFbF+n8+b/j1jsFVp
         s3Tg==
X-Forwarded-Encrypted: i=1; AJvYcCVefuF/3TzYaheYDrnZPmuvIgTNk2VHhTF8z8BGfLur8YwpYTYxSLcr3yjmr+LIXX6lA1o0Og==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzhLvNK8DEXjHdd61y27f9ManRCssz12NLx0uXKBoHE6/VliNn
	2nTtjes5vQzYX9RmW4+euuZz0lUzOKdS/leTgOuMxuI1s6NlqoSXNYZpHDKyXac=
X-Gm-Gg: ASbGncsuOC7FgowVh/86wD8qZMEc60y5iom2ns5keSYksZ1Z5dITV11G/JYF3F3VLk9
	yXtsG8YebJqzAlGf/t8JQRnWG+IKUJAkOUYsL6KFQX36yyr9m5lLAPIVJClkqmngqAo9xxVAIUE
	oF47vf3TZ6j6A/o3XOtKmzIEbPYOOkaXhYBwB03D0hEpGmNjoKvncezM9F2TemVcdg0b3nHQ70u
	QHCO1zixXiZ5zazU8EHIfcad+qLyGvNZp0Q6e7121Jj7OjwV2b0+rv8J+AaqN2Lv8DxwkTKgiD7
	qEF5vrjbxqoibBauYYicwvJG0lnoWA+jROkxKkUkQKFe0ZRrSWEtUEGuCjiBuuMZ01yzjgZCoH0
	=
X-Google-Smtp-Source: AGHT+IGhcywQo9UynmReNgmz8cK5z3uBFN04iFF5tXUNfFAh7UeVZti54hY8rHdrWU7tmvvAXTj/hg==
X-Received: by 2002:a05:6214:212c:b0:6e6:5a42:8560 with SMTP id 6a1803df08f44-6e886899d51mr50000726d6.23.1740575064570;
        Wed, 26 Feb 2025 05:04:24 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e87b089bbfsm21751036d6.50.2025.02.26.05.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 05:04:24 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tnH5L-000000007It-2YCf;
	Wed, 26 Feb 2025 09:04:23 -0400
Date: Wed, 26 Feb 2025 09:04:23 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>
Cc: Baolu Lu <baolu.lu@linux.intel.com>,
	Yunhui Cui <cuiyunhui@bytedance.com>, dwmw2@infradead.org,
	joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iommu/vt-d: fix system hang on reboot -f
Message-ID: <20250226130423.GF5011@ziepe.ca>
References: <20250225064831.63348-1-cuiyunhui@bytedance.com>
 <0691a295-0883-47b3-84a6-47d9a94af69a@linux.intel.com>
 <c059fb19-9e03-426c-a06a-41f46a07b30a@linux.intel.com>
 <20250225142610.GB545008@ziepe.ca>
 <888f41b7-dac6-4faf-9f71-4d7bea050e41@linux.intel.com>
 <33c4755d-6a0f-4734-88e0-84f0de67b652@linux.intel.com>
 <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83039906-77f7-4318-94bf-4c98bb3f0e32@linux.intel.com>

On Wed, Feb 26, 2025 at 01:55:28PM +0800, Ethan Zhao wrote:
> > Provided the system does not respond to those events when this function
> > is called, it's fine to remove the lock.
> I agree.

I think it is running the destruction of the iommu far too late in the
process. IMHO it should be done after all the drivers have been
shutdown, before the CPUs go single threaded.

Jason
