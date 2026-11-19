Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795100940;
	b=yfYZCOJFdPSnbYoplZ2jLVqlY3G3WH6heD/HfY5pBA2oqBMT+eYrAVQQcGxP5cW9piL5
	 iVxVQtX4AC9hB4C5DKzmME5S74dfwHLv7mqijSAaIFYEQM/W5nnCfybTWwa26lqfZ6GJc
	 IqAN7bXTeYvEQmYMCA5NDSMqWTshwmpGVn5PWDRHh+OTSK1KkGYLqdiHrKANjn37wrcAw
	 wCAgcFN7ANI2eupaxvyVDNZYbx9BJjNFSHO9CjcOaxIFl3dlgcCwYtxd7127CY6zMiD8Y
	 6RA+bmsSChcV3QZAQ+p0M0Va5/O6rC/DYzDjCiWcNAT6zxyD5JJ2o4nj5fxLfRvkGpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795100940;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=UfEaEG1JfkCAIJnh2gYW2V6ds/usdTdH+yyNEqHOfA4=;
	b=PQpxRBiBjol+RdRf7G8KuzjOk+8orTlevw5BiYenlP3e8ixwP99Qf2x/Q0YrpC5C2rU0
	 9k9rIdq89aph2Przu/c5ax1fl8OU3zb5hNFDdg6372CgZoRv+Ee5/8gd/gOSsbJffaxZr
	 9urBhCq/LhuK7GdUvfRgVKQGb9ZGvEkFZlCZ/nmcXsExueVdwDGeJJCoLw4pv0nj01jiz
	 PJl60mNmMa/XAohYwP72ey6xFxJasnBN9o4Pq7vctF+dmFjJfcJh/egWJxHmLfP55FbhC
	 3MJDJIeA/IdONZyZvwK1QoH7HqCia7tZZEVKPyACrQzcv3NKRzwza59k42g3DPFBAlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=U8cfhezj;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B058606A7C6
	for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 15:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B058606A7C6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=U8cfhezj
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-55ade1de0b4so24638011cf.3
        for <iommu@lists.linux.dev>; Thu, 19 Nov 2026 07:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1795100939; x=1795705739; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UfEaEG1JfkCAIJnh2gYW2V6ds/usdTdH+yyNEqHOfA4=;
        b=U8cfhezjT+1CmbBB/7rELBh+mJ1Pui7egbmv3itDklbCODE579efZR7oVB19Uf/QA6
         4JI1KAm6qySqXaaT+R25zCQfxP3z1ocnK6ZFa9DEVqsolxhBU6+5BDg7vuThMthe77iX
         zzvFqXGA2xNVNKZ83oZsuU2dAFRZVvGulLZ5FPXd3FsRwnsTxvPn446dCE4caRfHrE3Z
         9VPi8Jv8+RtzWbeKCS0sv8Le1aAs6djk86hyDvteVx5O5+06rA7p0D3WpenYUdIFIZIa
         fbnBGmbYbthMyZj5JCAjhijl1snRRNymgNriWFtrmjxjVEwfc1s/NWxsUQ/yezgo+OVl
         juRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795100939; x=1795705739;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UfEaEG1JfkCAIJnh2gYW2V6ds/usdTdH+yyNEqHOfA4=;
        b=Sm+cF5QWb840/gHiRBy8GkZOjNqy3Y+UZ/xU2+j6uTZfUi+UG008YUTwK5Q0npNEB6
         XmBZFBcGXaEfRCyc48TZswNiSu1Q7Qohw489A0KHsL/okiQoSBFAHZoo8K8GXLAIMkuu
         eOd2SdMCKh2dRXsfLqOJ43+4SMLdphGIYdVcqEF+I/vpMrznlxqdFD6eZxeG8KsAum0c
         +O4H2VCBAwlwTauywn7JiMGbS9d/28/arWlgTyN0pMJ68xVYHtgE26S4vJj7u8dUbD13
         rMoJXUGE74KTQfuhClIEj6AlFF6oe4abfDPL5K9Jo7+GFCBdwwzziWBbKCF6TVqFLz7t
         HfjQ==
X-Forwarded-Encrypted: i=1; AL+hErFzeaRgS18nY+zORuymdp0+BkQnZslL8jO2L3G8q4FtzOeCJUPJjVgTHjzaK2+V4ng5KaGo+g==@lists.linux.dev
X-Gm-Message-State: APuU4Z9bA70Z9juv6jWv2pxBsnExE0CgmU7V6SJvYkTf3n4RyuNK/Wiy
	LoaCDavu6Gz7OiIe6YKGrB1E7XziEOxH44+bFKihvNf3Q/75X/WEB2Q1vYflR4Sf1v8=
X-Gm-Gg: AYBFou2xhfN9xtna2U2zrPgtouZl646DKLhpkh9gSTRt0I+TLjYI4OLH8CdagIAg+lr
	DPHowIFYTXc6hOKF90gl3mMQH7sQAOvUpvE45ECsouhgj8wDulj/YaPG0/jGolPqI6l810vaRT3
	xYBWSq2Y7dvDE5HyY/dyIqIBGbaZa5qxJnq2uztdt+9KQU7YrCIi1td3B8rexZEqrraTz3kfbzc
	hOxp2AsT//JihdjZ76wVM35aGC6m3M9eEcmtQlQyJ20A1dfTPUA/LamxWYJ16/0VS6tlCcr4jdr
	Va8rkxlwP3EBaFUG32CUpVHVdwRVUfr9THp67kiyOZg4hs94wp6fHLe7MQvdFN+zx2/F7eoLpk2
	ZYng32fcCroGLaH2mZbhoV9qEDKOC9Wc+bDgxpc4UCopXV3p2yY59Ur/L8Lrbt8QuOnkGIyiPhe
	9MuWpEQq1rSRE71BNB+sCuqFshkql5vKoY6RjAxvXjXWb+Q2mXv7k/vPBhvArYZzXR/uyJIR4cw
	lAQCum2mBgcI6mTSXiO2ll0vfg3FFpZNpKfRgn43o7Fro8D7foQycGC2fi5ngnwULQngBQEHACj
	jfYUrg==
X-Received: by 2002:a05:622a:4e06:b0:535:2e9:e474 with SMTP id d75a77b69052e-55d76993c6amr3007681cf.4.1795100938908;
        Thu, 19 Nov 2026 07:08:58 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d669bb8d4sm25325301cf.3.2026.11.19.07.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 07:08:58 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xU3kv-00000000xbi-0Yi3;
	Thu, 19 Nov 2026 11:08:57 -0400
Date: Thu, 19 Nov 2026 11:08:57 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolas Dufresne <nicolas.dufresne@collabora.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, iommu@lists.linux.dev,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	driver-core@lists.linux.dev,
	Detlev Casanova <detlev.casanova@collabora.com>
Subject: Re: [PATCH 0/6] rust: iommu: add a paging domain abstraction
Message-ID: <20261119150857.GK3115493@ziepe.ca>
References: <20261112-b4-iommu-domain-v1-0-c29e86788dda@collabora.com>
 <20261116193821.GC2452510@ziepe.ca>
 <3EB4C2ED-B699-4532-A562-68B78F6E29C6@collabora.com>
 <20261117202055.GA3115493@ziepe.ca>
 <b145b2ceb92c73a4fa0477d7b3895a6e3b4adf99.camel@collabora.com>
 <20261118160909.GC3115493@ziepe.ca>
 <fe60c0bd-1ee2-4b33-8ca3-564ee08e6db5@arm.com>
 <CF2BE3BB-4F16-49FC-8421-B2B823BB7BB4@collabora.com>
 <20261119143151.GH3115493@ziepe.ca>
 <32a64e144c11bec72908ce143044773808be5115.camel@collabora.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32a64e144c11bec72908ce143044773808be5115.camel@collabora.com>

On Thu, Nov 19, 2026 at 09:52:59AM -0500, Nicolas Dufresne wrote:
> Le jeudi 19 novembre 2026 à 10:31 -0400, Jason Gunthorpe a écrit :
> > With the additional twist that alot of embedded HW has apparently
> > choosen to not implement SSID but instead has a pool of SIDs that one
> > device can use, functionally similar to SSID.
> > 
> > We'd need also API support for unbundling the DT iommus=[] SID list
> > into something that the SIDs can be attached more like a PASID.  That
> > need, I think, has become clear with all the DT tricks and fake busses
> > to try to work around this issue. :|
> 
> The word "fake" never flies with the DT maintainers. On that subject, I still
> don't know what you mean with iommus=[].

When you write your DT you can list all the iommu streams in one
iommus property. Like this randomly picked out of the DT files:

        iommus = <&sysmmu_decon0x>, <&sysmmu_decon1x>;

If you do that then Linux sets the struct device containing it to
put the same paging domain on all of those iommus.

It doesn't make any sense to open code this in drivers when you can
just have the core code do it by writing your DT to match how the
driver wants to work...

Jason
