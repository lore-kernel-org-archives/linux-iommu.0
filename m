Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F83017755
	for <iommu@lists.linux.dev>; Wed,  9 Aug 2023 14:46:12 +0000 (UTC)
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-63cf69f3c22so46482316d6.3
        for <iommu@lists.linux.dev>; Wed, 09 Aug 2023 07:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1691592371; x=1692197171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kQ0GZ0yzt/8W4uy4P4Z/I177D03RKL674Kj6QZAd/AA=;
        b=hmkKqCvkzPsV0bto0g6pBJxXJtgUX3UxCqy8t+FH4d66nm7X7puRglM5O+XOQysD9Q
         duiUZjRWNnyxwkdFE6ZDghW7gOYHJFQxuZc81bz3EDIcxMwnVkEp9Uv9tWDy2OwpXmrn
         8tSYBYcyfbBXtYDP1hrgc9dwWqmQUOXZHiJMrsfSXcryp9Tx64SjX47Y9/IVib709Ujf
         aZ5bq1p3723mU8Mrlzzx1GlyUoJVLm3iBpdOyO1smjo0nLxZmOp35i77beEEAKtb3p8B
         naTkUNa9dAkNg2pJZoSfp+cyv+jmJWwF90PrggkeX8YZMumS3JUJZyLF6ogV3u3DdxgX
         Yyag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691592371; x=1692197171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kQ0GZ0yzt/8W4uy4P4Z/I177D03RKL674Kj6QZAd/AA=;
        b=CcPxInYgCAuLhDoOPA09ZJlR12Upf3SkEEGuB0F2ovj7lmCJXE0WPGLf/LsJS2UAgo
         wYI5K1UjKZx0T9euvOeP8kNfUH6A6L+sC1EgzYDutqRWXac8BwiVQEtqyXW7gz4jKFAB
         1YGYi7nhEQ23YxQYvbpz0hy7VyOAALlygJAhgIzsT1vy16vnhd/+b/ToBd64oJILK9MF
         f9xyC/19VJgnaDV77KZ4hORQlNrRWY2NK3pH4YO5pc4zUH7qs0zgue6CUW1dQRRCAAEZ
         CVJ9Hg3IM5aetPeZqOtojWaDGlaCBcrlb9xaRJS9xOMUGy/Uin+btPfp/6G7iaZEYKR3
         pXXQ==
X-Gm-Message-State: AOJu0YzKMUhBjsdO+qReQvLQDojCn3FKXi6YNeSnvAoYKohQGlCOi/sW
	IY681QiIXDNDtxA+5IW0kQC6LQ==
X-Google-Smtp-Source: AGHT+IFxDp9b5anjg4l638qo1HdNSxBuX63J0F2pyQekhJNEI3iLua1YQM/4YVXD0fOsIaewXltdWw==
X-Received: by 2002:a05:6214:3d09:b0:63c:fbdd:4592 with SMTP id ol9-20020a0562143d0900b0063cfbdd4592mr3460764qvb.31.1691592371164;
        Wed, 09 Aug 2023 07:46:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-25-194.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.25.194])
        by smtp.gmail.com with ESMTPSA id l9-20020a0ce089000000b0063d5a7871d4sm4486731qvk.78.2023.08.09.07.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 07:46:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qTkRt-0053ZQ-Rl;
	Wed, 09 Aug 2023 11:46:09 -0300
Date: Wed, 9 Aug 2023 11:46:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Tina Zhang <tina.zhang@intel.com>, Kevin Tian <kevin.tian@intel.com>,
	Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Share sva domains with all devices bound to a mm
Message-ID: <ZNOmsfE3Eheuelv8@ziepe.ca>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <184044ad-880f-5452-727b-f7fd18330c22@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <184044ad-880f-5452-727b-f7fd18330c22@linux.intel.com>

On Wed, Aug 09, 2023 at 08:18:18AM +0800, Baolu Lu wrote:
> On 2023/8/8 15:49, Tina Zhang wrote:
> > A sva domain's lifetime begins with binding a device to a mm and ends
> > by releasing all the bound devices from that sva domain. Technically,
> > there could be more than one sva domain identified by the mm PASID for
> > the use of bound devices issuing DMA transactions.
> > 
> > To support mm PASID 1:n with sva domains, each mm needs to keep both a
> > reference list of allocated sva domains and the corresponding PASID.
> > However, currently, mm struct only has one pasid field for sva usage,
> > which is used to keep the info of an assigned PASID. That pasid field
> > cannot provide sufficient info to build up the 1:n mapping between PASID
> > and sva domains.
> 
> Is it more appropriate to have the same life cycle for sva domain and mm
> pasid? I feel that they represent the same thing, that is, the address
> space shared by mm to a device.

No! The iommu_domain and the PASID are totally seperate objects with
their own lifecycles.

The SVA domain should NEVER be tied to the mm enqcmd PASID.

We might decide to free all the domains and keep the PASID around (can
we even revoke the enqcmd pasid while the MM is alive?)

Jason
