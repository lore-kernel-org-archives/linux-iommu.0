Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC9343BDD2
	for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974267; cv=none; b=l90JZEZaXzYS+Ve1S3Rz1pPK3bGFrFkrFDmslPDeGl1RlXQ/YuhFAdtN9CmE+BNDth/NWHVsCHI/NxGrywW8TQIrlkpGNVxjiVQpNtc+R8mLyiuQxSYXf+jvOJnwiCHm7u2h4MaxsjcZD6bXqiTzBVM9j34NqdNXkpEoIIpzqow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974267; c=relaxed/simple;
	bh=l1KmbxaSn1vlCmlCKqGoPg+3lItQFTLM7H5zRTTjdlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5lK0Y36+uFluD7V9oOSnLPeQQhiYhlGJvXHLkb+fFCXkYGesuOROBVAETgnYoWRndebC/DLjZ1U6Ptd83neZpdPeRBc0Hm48LrL72VKIJRJ5jkDuqldaCmifRYS6gGwQKzu7aw5lGXXrYexLZZKh76LtRUQ85+QJEjhuXvbrJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=SZWY+Cyc; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="SZWY+Cyc"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8f186025973so31620016d6.0
        for <iommu@lists.linux.dev>; Mon, 17 Aug 2026 06:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1786974258; x=1787579058; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BS4TBmNsymnramXeNmNZhBmFeFZI0B72fRANMpt3ZzQ=;
        b=SZWY+Cyc1v2CrpXeWczDzFqneCU9ygripk+vlqTLxvZe3EcyD3kuVMr5jRAGHPu3Pv
         GVU5AWroO6V2dnyuS8hejsSQRc8pXSRh+2e3z4JwcGa4YP9rnyD+tXYiWtn1n/0x2IwE
         xMeb45YPE73Io3RrnrXjeDgdJpODM8687UuX6GptMNO85aVwbp91weIunDRd2blWiJch
         KTqTHaukSM3D/+g6H0fj1yLLoddF08NlinQ2wNN5ZO571IxEyimcXI9jVUOTI4SRwa7U
         4Ot4jk78tw0bDMxE2toodvzm23X9qHE9mM/OEgwzq2uiIWuvtnRtVWGz112nfnCEIsiC
         UPhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974258; x=1787579058;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BS4TBmNsymnramXeNmNZhBmFeFZI0B72fRANMpt3ZzQ=;
        b=kn3uPxO9Y6DpzEU431ywBM2N9VwZUYwk32G/a3L1VQyU8g7Avu7OuEdKY7ru9LHczj
         aIURgTVYbZuAaDP2iGMrKl9Ri6HP0J8gu1xDEsgpNoNJWh3W2lwQowbgzsCkxfSL/8jU
         tw4/eGLxejrNnC9erk6hbrCbhs12jcaOusdLIWvxkvZoZuQenfdHbq98t9T25zU+L31a
         3OcDy3CwySh6XfBmRE/tpieW9AT1WkFMx6343Oo8h9E8REG0eGD6Pu9LimuNM/8E6es7
         vxEd4efU+J1noQIUl6dz765LtEoqE3w1vp4zyyFwaAk1zya9gAhxDznivgOgZ4pvvFEy
         Mbkw==
X-Forwarded-Encrypted: i=1; AHgh+RobVNHq6ei/IDFfxchFAAxGumvTj5PRLHpDqVaAIPCb1cqBdhB0Gh1u87KWQiQ0bkS45fYcaQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXsiSOmZCK3nscmW4GhuWi3nW0nBwNqP6aMwbIgsqu0PoDPvPo
	MUO8TzcNpWM9PwjLB5j7DqawhY+eaySXlYOkpCwb2ZdOyCFrmvzIlbvVoxNxaoT+DOg=
X-Gm-Gg: AR+sD11t2Rnm/neAWPhuy/o+n8WokZhiRzy7Uf2pDXcRskOF7kBtIIvJvbNUbPBh9j4
	XAmOWK590tZlrJUhD1c2/zVqO+slU1gLxjEQYQ48GYZzoa3sUaVX2ow31GERzlV9jnB3skY1SLi
	TfnsU7BIpGz6jXFKwvKhtzWEXb9AOz8xSBq/qrx02WxNe4BfPOaoEnS2V23GHA/dzNTRL2fLzeh
	NRuiL4MJjnpLIMab9fWOE+YfgJVS1Fk0MMGDbp6tHVoq2kZPnd2dBApmHgNNvC9298nwHDjughg
	94oPwTG4zTEkcmAPpBeh5CcFQttt67sjMIevM8INNYmvoqiwNMCKqGhduSWXboLmiO8uGTNWnTE
	JMevpXIVk7NWokYN1amZkLNOumH0z9AUQ8PK5tos3fSKtoQ7IK98nd9ANYiapCSXeIhVjlsb3Qn
	lcQArMnZK2cHusfuKZpF9GZrwiciFk/HNbJwIZgX9QnXZiEtNi
X-Received: by 2002:a05:6214:2029:b0:8f3:e97:59c6 with SMTP id 6a1803df08f44-90a91dcd1eamr322787926d6.20.1786974258222;
        Mon, 17 Aug 2026 06:44:18 -0700 (PDT)
Received: from ziepe.ca ([142.166.156.215])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c45986ae7sm9166026d6.48.2026.08.17.06.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:44:17 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wvxdQ-00000005wLX-438N;
	Mon, 17 Aug 2026 10:44:16 -0300
Date: Mon, 17 Aug 2026 10:44:16 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>
Cc: Oded Gabbay <ogabbay@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Bharath Kumar <quic_bkumar@quicinc.com>,
	Chenna Kesava Raju <quic_chennak@quicinc.com>,
	srinivas.kandagatla@oss.qualcomm.com,
	dmitry.baryshkov@oss.qualcomm.com, linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, llvm@lists.linux.dev,
	iommu@lists.linux.dev, linux-media@vger.kernel.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [PATCH v2 05/15] iommu: Add QDA compute context bank bus to
 iommu_buses
Message-ID: <20260817134416.GA1415075@ziepe.ca>
References: <20260817-qda-v2-v2-0-69a02e9090d4@oss.qualcomm.com>
 <20260817-qda-v2-v2-5-69a02e9090d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260817-qda-v2-v2-5-69a02e9090d4@oss.qualcomm.com>

On Mon, Aug 17, 2026 at 10:17:40AM +0530, Ekansh Gupta wrote:
> Register the QDA compute context bank bus (qda-compute-cb) with the
> IOMMU subsystem by adding it to the iommu_buses[] array.
> 
> The QDA driver creates synthetic devices on this bus to represent
> IOMMU context banks (CBs). Each CB device needs its own IOMMU domain
> so that the DSP memory manager can enforce per-session address space
> isolation. Without this registration, the IOMMU subsystem does not
> probe CB devices for IOMMU groups and of_dma_configure() in the bus
> dma_configure callback has no IOMMU domain to attach to.

I didn't notice a clear explanation of the proposed DT schema for this

But it looks awfully similar to the other driver that was creating a
kernel synthetic bus for actual real HW, that wasn't well liked.

What is this for? Why can't you have a normal DT binding for the
iommu with normal devices?

Jason
