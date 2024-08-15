Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F251AD9FB
	for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 15:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723737051; cv=none; b=mbAYDPKA0fQD5TmclGiEjZt3gZB2uwFgkN1vyOx6UiHbI2JpH2QHf+Z/H9DRi/DO3fMyTeNRDJz9tBEzYZ6iV36Xb3omN3ZomXRqIrKnkhnb0irMFTFqGsd4Bxbk2MiP8cQl3cLj2irc5Bu1ZiDZ2flv3QDL2mF6kbgBGd/LUZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723737051; c=relaxed/simple;
	bh=aZMMrFg1Di2xRaG2PKPTFXBs0pUsALFa/TvWiZyyiLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lUlqqzxxd6QooUy27gMrsoZeTXJ0ppv6lcINixVPugTbiXEStfrPghLRE8zbTLtwt98FlPCHnHZ2FIZvazhvlxZWS8Hf2zURxGq7x+X1QRD5kJuzb8TAHjANxolNLcSLzSF6ZUado3EF9+Mj1M+WHYrnu1l1S0r+h+DR6oWbKdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKG8O7LP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKG8O7LP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723737048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PAxsRmRTyiybxBmaIn5tpwbiask6P7OilLc948K2bLs=;
	b=NKG8O7LPHh2Oc2oJcyuQMJL6/i/ePdZo8tSRvHEyTzWJF4OSOpUUThKjXH2ekINu6KdkVE
	y9qWqhNfkVkw3O2htxUBMsKUgnAWzi4/DJksFCcnZWGKDnC0PqN4YcAgfohIQDZNNnaaxe
	gjbjRPfeFaBD4Dkg8d99fnKsRf2IqjA=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-124-InTGmSj8N326vd89EQOIsw-1; Thu, 15 Aug 2024 11:50:47 -0400
X-MC-Unique: InTGmSj8N326vd89EQOIsw-1
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-44fe92025d8so11148551cf.1
        for <iommu@lists.linux.dev>; Thu, 15 Aug 2024 08:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723737047; x=1724341847;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PAxsRmRTyiybxBmaIn5tpwbiask6P7OilLc948K2bLs=;
        b=VsU/G86ixjC/4gpf6HbqQkxYYL6cNAt1JJsJIeFCEuA3j78872oxltj7Of2Wbyhu5C
         /0c9bX91picqZd7BClnZClmqD52xuj04SOFrE8kKvabEdH/89xcd7iIVvArpdnfkybQL
         XtGZaiNV/j2k0u3V+cccgV735CNWIJFj60/L4+s2W/1hBdkBp6wN8ATYJ+Cz8mXLtaAd
         tGmevr6BWlIBca9CH3A3pKTHfylQ0MFCZke7Bxeqg1LRsBBGmYsOcckPTIUFh/AFrE2j
         eVj0yDe9G8wTCjM49O56fBDzbXnpo7sFho+KqnLKQoJChP3ujvsVoygEkdMJ99z3fgX7
         4TfA==
X-Forwarded-Encrypted: i=1; AJvYcCXg/xE7p8LpZldPJvXuVWXhAcHF6h/25TKfvAs/EBZHwUOuIz3MOWRC5qtjzbIFvNdiduB0LA6TXbK7N+oZF26ljw3ZPio=
X-Gm-Message-State: AOJu0YzuWGnf0RiUtffPF7Yo7QjoX8ESgAI1id0jNZNVmyqgSOqK+yJI
	R7hcIoPeaSsH8IGEaWM1Fr/9UH6kObJK5dhrMYmYxxXsp485pmU5oGWOBSjQv+5lyad9+NpoW+W
	Klo9XuGZT7KxH38GUQfQkHs+fg1I/eJSukJXJULyqTxMLCjvdxao1
X-Received: by 2002:a05:622a:1926:b0:446:63e9:dc70 with SMTP id d75a77b69052e-4535bac5032mr64655181cf.19.1723737046850;
        Thu, 15 Aug 2024 08:50:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqP3a6s1mqzTrSrz9yk0OPDqMqwt5NymJ/RFbenIfPN48g9k3i8WzqT2MFSoGpCReyDysJ/A==
X-Received: by 2002:a05:622a:1926:b0:446:63e9:dc70 with SMTP id d75a77b69052e-4535bac5032mr64654891cf.19.1723737046501;
        Thu, 15 Aug 2024 08:50:46 -0700 (PDT)
Received: from localhost (ip98-179-76-110.ph.ph.cox.net. [98.179.76.110])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a04e4e7sm6814331cf.63.2024.08.15.08.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 08:50:46 -0700 (PDT)
Date: Thu, 15 Aug 2024 08:50:44 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix incorrect domain ID in context flush
 helper
Message-ID: <cgz2k3p6hiwsbpjszt2r6ecw3hrasqvoovymb7cxyum6f65ayu@mueqgrbehmr3>
References: <20240815124857.70038-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240815124857.70038-1-baolu.lu@linux.intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 15, 2024 at 08:48:57PM GMT, Lu Baolu wrote:
> The helper intel_context_flush_present() is designed to flush all related
> caches when a context entry with the present bit set is modified. It
> currently retrieves the domain ID from the context entry and uses it to
> flush the IOTLB and context caches. This is incorrect when the context
> entry transitions from present to non-present, as the domain ID field is
> cleared before calling the helper.
> 
> Fix it by passing the domain ID programmed in the context entry before the
> change to intel_context_flush_present(). This ensures that the correct
> domain ID is used for cache invalidation.
> 
> Fixes: f90584f4beb8 ("iommu/vt-d: Add helper to flush caches for context change")
> Reported-by: Alex Williamson <alex.williamson@redhat.com>
> Closes: https://lore.kernel.org/linux-iommu/20240814162726.5efe1a6e.alex.williamson@redhat.com/
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

