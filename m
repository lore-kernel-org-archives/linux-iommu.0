Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E5938B7D9
	for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781725241; cv=none; b=FPwZl5UtpIWBWk79CX5iid2YD9147NGKL7ws2iJZ9ynEdruLl9UpccawQRpna2pnszoLIdxTZ57xt/LUwYhkEhID3izOsGsy7Ewxd1DQ2WRPvGMKjZ5GZD8NdPFUCUoff2Lu3PUxtjyGmv7j+swa1NEOr/GJHOOGoQdHRg6JGb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781725241; c=relaxed/simple;
	bh=hC0tkmk3CwlTw60oCFg7NktYyWjvd8xz26/0DNfn94k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sy6DtY3eFhyIcCaoVQMM8o3777kERqu4YKf+MLWCqMZ7lnIjHT6H6SQFB+wMI3JEeSX241A92rLGYtj19beshJkQZ4BfW5U8/uxuQTK/YeY8r//1nneCbI1mgijYOLcZAhwcZo6ubuV20x5lOFSzTfrmfiYxKjz5zgR7pSgVqvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ovglmASx; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ovglmASx"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-517a5cafc3dso1228321cf.3
        for <iommu@lists.linux.dev>; Wed, 17 Jun 2026 12:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781725239; x=1782330039; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7eyy4O5nzOr3kbi79Do1gW5A4O3qVnxOxdqKH9iTYAY=;
        b=ovglmASx+CWd1FQML4kuPBxFaGOnmK2B4yeJkX8qFfM9Fh2QTaG+4RFqni7FsptwD7
         RL8vkIdGr6hiSNI7veWFG6v1ldQt522FKerhWptsZqLnAjAm7UoOd6gzzPUJhv17OwJ7
         nmyh210iS2Qy2pG+WSUoxPHlOEP0TcOkVTt9YoqYjZXsBWBJFrEcqgqgn9nZqdUM6/OI
         28vOGtQUgD/2JIHSgE3bLNK7sk7qmvGYa6AIyY07F9z6pOoz1ljWvGtyn6+yLLIuzRGB
         WmVtkuEFtEnrK8aXu7WMlSXFGCecqWiWRPCDPrYWOi2dErFFpGFms57uLpsmpgMLx+Dt
         jkFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781725239; x=1782330039;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eyy4O5nzOr3kbi79Do1gW5A4O3qVnxOxdqKH9iTYAY=;
        b=JYRUOIcAsrrFB39/qa8v5f2/3eCpOwwKHY7+5WSbV5A47GQdrMzrDtMMtSspJvvWDM
         afjTmDg4Fukj5d1q5MtuFF9Qn2wsx65V7i+UGV3NjNzfIKqSZbPD0b2DTgD3grxyZpo4
         4hBLlPR+kpmZOQHNZVILxM+4iSGC8Icxc9edL+teJzQZfQpfLSA7RoGd2zE4iRF+pkSW
         5MfrF24XLPCbIH1a2h5eiH0wrDgXo4LhC3IPjHpCcAJES0bmutyrZxipfQ0f5NfabUqj
         ycHEI8lvfq1CpfiXyMxUAUOGEGmtnJl7/arOrdUlRlr4/acrvyJh2XPlF089yUz/ap/D
         r4Dw==
X-Forwarded-Encrypted: i=1; AFNElJ/mhYdiee7XHTFSUc/5sy8YvR+64/z5ccCUvCIAmocbi7Ep5tosr33TUhA14e+qhCreZ1ntYw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ+tvkGVrBEV7FdJZjI6tsSv4nEYHEippN+XFsfxK3l28Mzo3e
	+u17SJsmqcAuXcMmNwgymjXwzONf3yTSYesZrMEN3Jzhn3euIbyjPtYMeZyjF0S1vk8=
X-Gm-Gg: Acq92OGRobczvWRSg4eBZ7LdQgXOOxCmn9TE1wMBVeyBxMc/7of7/eQj2lxnDeH2MIr
	cIZRwC+Bn9r4NIk2RdpyVIL6NKaCrFpeELzWR3Y8/0xWoNsMqgQyamSoImHkk6wPnYejKsCku4d
	TQ3rU167ouPL4/O/0H+BZkN8StsIPe+bIvs+3jOSlXFmkq/U5KfdAaU+9N07sPbQ6Bjv3NWZSTf
	WRee47+OiyQSW96wkRCkir6ThrmEF0pceGTyqIRrFf9GZGFBYZ/GTPkj1wKZM8LmFIQfYE8Y7E+
	yQHHd+8x2ilEshjljr6z1u4YqVjeUitOJwXtO7of9SSpL5g33qrWoJwndOPYX1xWeuB25ePluHT
	x6c7jLdyqGYHLRj/inuC6mNcoOMXcbDXKechWIbDIL5kL4ShcZDIc8MN4+zHSvGOBBo6h0gCq9m
	dDjAOg7tY3/qKMrbjDBYxC9+nYRIGmLCb3cF6qK8fuxKFRsvTvXKmXmfRAK11FVVF7iUs=
X-Received: by 2002:a05:622a:1143:b0:517:b750:642 with SMTP id d75a77b69052e-519a8fd6aa7mr86533811cf.47.1781725239506;
        Wed, 17 Jun 2026 12:40:39 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-519bcf349cdsm12342151cf.13.2026.06.17.12.40.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 12:40:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wZw7q-00000001BL8-1aAs;
	Wed, 17 Jun 2026 16:40:38 -0300
Date: Wed, 17 Jun 2026 16:40:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
	will@kernel.org, m.szyprowski@samsung.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, dikshita.agarwal@oss.qualcomm.com
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
Message-ID: <20260617194038.GC231643@ziepe.ca>
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
 <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
 <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
 <20260612172649.GM1066031@ziepe.ca>
 <da77c21d-25b3-46c3-a48f-71f0549e9f5f@oss.qualcomm.com>
 <20260615125257.GS1066031@ziepe.ca>
 <dcc0d02e-91fb-ddbe-399a-0191bab94c4f@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dcc0d02e-91fb-ddbe-399a-0191bab94c4f@oss.qualcomm.com>

On Mon, Jun 15, 2026 at 11:21:45PM +0530, Vishnu Reddy wrote:
> Hi Jason,
> 
> Here, the parent node does not have an iommus property — it only has iommu-map,
> like example below:
> 
> iommu-map = <0x0 &apps_smmu 0x1940 0x0 0x1>,  /* function_id 0 → SID 0x1940 */
>             <0x1 &apps_smmu 0x1943 0x0 0x1>,  /* function_id 1 → SID 0x1943 */
>             <0x2 &apps_smmu 0x1944 0x0 0x1>;  /* function_id 2 → SID 0x1944 */
> 
> When the parent device is probed, of_dma_configure() is called, which
> internally invokes of_dma_configure_id() with NULL as the function ID. Since
> there is no iommus entry, no stream ID gets mapped to the parent device.

Sure, but it still did of_dma_configure on the parent..

> The child devices are created at runtime and have no of_node of their own. The
> only place the iommu-map property exists is on the parent's of_node. So when
> configuring a child device, we pass the parent's of_node along with the child's
> specific function_id — this is how of_dma_configure_id() finds and maps the
> correct stream ID to the child device only.

The whole thing seems like the wrong way to use DT to me. Having an
iommu-map in the dt that no iommus property ever uses strikes me as
abusive.

Then hard coding the ID table and manually creating the missing
struct devices in C code is a throw back to board files :(

Of course it doesn't fully work, it was never intended to be used like
this.

Why the resistance to doing DT properly with actual iommus and dma
ranges for each and every stream your device needs?

Jason
