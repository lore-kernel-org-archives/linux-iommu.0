Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B9C97FBBB
	for <iommu@lists.linux.dev>; Wed,  7 Feb 2024 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707319738; cv=none; b=UcFXeDvllrMcMAI3HrN5CG+5Ex45U5cgSaE2RFX3g/Tj0b1F1an8BsisgK+VnVdGu0qit+ksdEpIEEooGeYobzsHg/Q75vHqxcnx7K7OeSpDPkQa+hQpkQVPEMJDOLNRcNd7iUaN6mMuFGoYMwjati/sZcASMyror4JlGcxCU5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707319738; c=relaxed/simple;
	bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s8KR+Yt7dijrgzsf8l3FZwJnQGS7Ue/dyBKME4esmr6ZyVWxCw82PHHfMCPJbrKy+TFiGS3bKz5Zzz6dXVBl8zdnMD0C1IuRVWZEYm4oF9Lrgwn2YjTds2nWlYiNm9b58ney+/GQT/puk1Ev4ZKbZ12hN5szwu4W5WckKOzmCNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=T9qOssYl; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="T9qOssYl"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-219452bdf81so463373fac.2
        for <iommu@lists.linux.dev>; Wed, 07 Feb 2024 07:28:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1707319736; x=1707924536; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
        b=T9qOssYlrVCe1bLDD8ZEazvpSWkZxOZenmoTJ+20v9MKrnogvZVF2J8hX6l71OTDDA
         ckR104oMfaa7a6nKQnEYdqqIoRPxyvy3UGSlgwZj7xfyOGgsUVv4przCL745mWWbIwSi
         TSMVqgQ5Qmwbtrc+we0AjiEoyuNSxORMIzNUu0FtKgswzninooTgRUG1KOnERmnM1fsn
         FJy5f/zdXWr1xd/oFjAThD8GLKecq2x7z/F5a/IwYPvEjHqRi6HGge1sTZokF3PPwAIA
         fLdkRqDrBzEqLCm+jEIk8V9DdRFfrX7wrLbHbxCyKzAkIT6okbQg5htab7hFmEiRG1Pj
         cS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707319736; x=1707924536;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KgcZE+tbSx7VYsRad6qU230OGLkbrGEcFdePnG3XBqw=;
        b=r3TJ1F9Yjgc8bIaw3qhLtRhW7M9WhW6nzyLbqV1RIDJpBTVC1WGse0ln/7D3xyPyYw
         SI6Esv1vB79C2JlwqD3SW554G1jhVFi/xh8hEPQTMesGeFVfWB4PGxnKYEWntr4Lm1l7
         8gQxUDXtzr9F2J/cwaM/vSGyhM+jJ2grcrhKglWQgEboaIG+nlSny2sq1NZfemcX7rvk
         c3pwkU1wIiK7p4YhE18/rABvlUFrsRppO21EFTlVMRpBYNlEiY/Jo2Ff/mv+4mrvL729
         PV61lhU6WNcmdR0qH3Vo4XQo6jHav1cTCOJrZUtK//GWmsX71MH2wrdbb73aWbDjd1jC
         MX7Q==
X-Gm-Message-State: AOJu0YyWW4OqxOzZb0A/uQIK52HuMXiK7KG9p0eOk1BdyqKkPpgVUPW1
	ypLv5cKObveBD75bedX1XNcaaa9bXmx45v/9HOXJUw59HE2F4R3b7GYHMtbNDS0=
X-Google-Smtp-Source: AGHT+IHEL7CFznI2Gw3SaxhMoycGQY1ZAMJ2M/MoHIzeasU/nr/2JepWSFEuheW8Ams28t9PtymRRw==
X-Received: by 2002:a05:6870:bac7:b0:219:83cc:287c with SMTP id js7-20020a056870bac700b0021983cc287cmr6065943oab.18.1707319736190;
        Wed, 07 Feb 2024 07:28:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUY+po1giBXhl03Vf0urto5lU8KkUE0xa/D+uEwt3aAnuuk7whgR0HTCfY+MTVQpslUqqUs/wsMp+t3ROMVbRdiv139tCe2ZBXKAtq4ZceV9PQJGgSNRI8IXanfewIYC0pI3FzZsKmRPGCkekyIVSuYunEdq/NKi0/3z9aOOnSjGhG1HWtDCKx6tkf7sG69wd0voFNXVKcPnx/Nm+iJxlnF6OfGX8tZ9W5Ef2TdHxCT40iWFJmfW6S8uQKXx/coePehrn7fBGc1ApNtwTAo8s/s5HRc5UVF5kRUR22WO8nHBRkrzcJX/Ul/xP8hPJikjNY5otCJsvQrEVBk2ZaVzx3MkqaDTyR4Ul7c2lNd1sQoJE9R4hMA5FyNT4k6cGm9+PELO3Pd2X6HZW5Jm8qV/VAErzvt6LcaoXye2Wua/2AYMT/wp1V94k8M1zgi8oPWuI9edPTgsfIAIs+qSWZnIHymtDR0ZDoa4pbEKoLlGJm39ZpBPkOgypT7AHFEI8rU/GAr/BBLOvIN75lw9qDVd4OTS7E4DjE+P+TXjW/ejHtWFFjkRAxscCfnxXGlxTCjMW8flXh31SrWNWQb7kthgrk5FZ0nc1rQCTq6Q8fWQP0Awd0gAJf2PwiCs47eD05aetIREJ1Gf81uCiJ/HxdH+LBZUmXJT18VOvJdRMBqtyz
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id p6-20020a9d76c6000000b006e112c93b1esm228799otl.6.2024.02.07.07.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:28:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1rXjr4-008ccK-Kk;
	Wed, 07 Feb 2024 11:28:54 -0400
Date: Wed, 7 Feb 2024 11:28:54 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Gowans, James" <jgowans@amazon.com>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
	"kexec@lists.infradead.org" <kexec@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>,
	"Graf (AWS), Alexander" <graf@amazon.de>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"anthony.yznaga@oracle.com" <anthony.yznaga@oracle.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"steven.sistare@oracle.com" <steven.sistare@oracle.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"seanjc@google.com" <seanjc@google.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"ebiederm@xmission.com" <ebiederm@xmission.com>,
	=?utf-8?B?U2Now7ZuaGVyciwgSmFuIEgu?= <jschoenh@amazon.de>,
	"will@kernel.org" <will@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"usama.arif@bytedance.com" <usama.arif@bytedance.com>
Subject: Re: [RFC 00/18] Pkernfs: Support persistence for live update
Message-ID: <20240207152854.GL31743@ziepe.ca>
References: <20240205120203.60312-1-jgowans@amazon.com>
 <20240205101040.5d32a7e4.alex.williamson@redhat.com>
 <6387700a8601722838332fdb2f535f9802d2202e.camel@amazon.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6387700a8601722838332fdb2f535f9802d2202e.camel@amazon.com>

On Wed, Feb 07, 2024 at 02:56:33PM +0000, Gowans, James wrote:
> 2. Tell VFIO to avoid mapping the memory in again after live update
> because it already exists.
> https://github.com/jgowans/qemu/commit/6e4f17f703eaf2a6f1e4cb2576d61683eaee02b0
> (the above flag should only be set *after* live update...).

Definately no to that entire idea. It completely breaks how the memory
lifetime model works in iommufd.

iommufd has to re-establish its pins, and has to rebuild all its
mapping data structures. Otherwise it won't work correctly at all.

This is what I was saying in the other thread, you can't just ignore
fully restoring the iommu environment.

The end goal must be to have fully reconstituted iommufd with all its
maps, ioas's, and memory pins back to fully normal operation.

IMHO you need to focus on atomic replace where you go from the frozen
pkernfs environment to a live operating enviornment by hitlessly
replacing the IO page table in the HW. Ie going from an
IOMMU_DOMAIN_PKERFS to an IOMMU_DOMAIN_PAGING owned by iommufd that
describes exactly the same translation.

"adopting" an entire io page table with unknown contents, and still
being able to correctly do map/unmap seems way too hard.

Jason
