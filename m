Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB822E6CDB;
	Sun, 18 Jan 2026 14:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768747397; cv=none; b=bcA52gOwJj+DCJqTH5txqQOuooxSqPEok/zTwyzAZ/dG5NI4L20SxBnLk/Jy4A6HGTU7ymo5Xlh1fJtRoybNZrPh/jCLaFhysKyJNBvm3PNRGmvdkmr9sqv5Y60upV/b+JQtS3EP/Vkb+oYVJjnbj6ZU8s+9XaYOilmDPfLlDFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768747397; c=relaxed/simple;
	bh=yX8tHO55GG/mldRK8FReFu4hUyBgKBvnvLpvUpXR4vw=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=HjRS4A/zJ8INQ3xaEgB6fzNtwBR2W59rf53/+gUUmjaYdPnjnU6Sc523kUxX1WSKzuNDu0VmRf05s/XcV0xn3Jzem+9ADOt4Is2LJ8Sx7Xe7yYWBiJMAwr9JGGIW1Ntn8e7ljKW6wd+AI5oKtLiMoIIXKTqaaqEAASXkck7PYTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZImTKomO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZImTKomO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D0FC116D0;
	Sun, 18 Jan 2026 14:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768747397;
	bh=yX8tHO55GG/mldRK8FReFu4hUyBgKBvnvLpvUpXR4vw=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To:From;
	b=ZImTKomOzrrVe1xZacVnD5Fr4WMFOuE6565q6gXiTLQyJHqIs2HF1PlT60wA2ndgI
	 Vrz9qnvkebtJSZ047onnK2zosQX2ov6uDnLLz1xf1WA3LuXbfeT+Wif6sUAPdCsAW0
	 WG70u6acSzHKeZ5MRxrX7H7hK8gYXtI3DEWEHowfggfzqbmRLjKt0NBl6eV/8YUxr9
	 474KgqLIsd3SRusA0xvnm/s2jImxQOoD5FPUPr1sB3GflI0DkYoN7Kjz1Z5OTZPb8P
	 FaLS4y7z4W8TScormZyX2cq178xI/yEESoBFG3qUYvnL8ZQxtL0LRjcU5GXLYf+m/m
	 rjlxBo+AdmfYQ==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Jan 2026 15:43:11 +0100
Message-Id: <DFRSME7WFXY0.2XQSN0VXMI9MD@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v6] rust: iommu: add io_pgtable abstraction
Cc: "Joerg Roedel" <joro@8bytes.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Will Deacon" <will@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Boris Brezillon"
 <boris.brezillon@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, "Asahi Lina" <lina+kernel@asahilina.net>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <iommu@lists.linux.dev>, <linux-mm@kvack.org>, "Deborah Brouwer"
 <deborah.brouwer@collabora.com>
References: <20260118-io-pgtable-v6-1-423846996883@google.com>
In-Reply-To: <20260118-io-pgtable-v6-1-423846996883@google.com>

On Sun Jan 18, 2026 at 11:08 AM CET, Alice Ryhl wrote:
> +use crate::{
> +    alloc,
> +    bindings,
> +    device::{Bound, Device},

NIT: Wrong style.

@Joerg: Maybe you can fix it up when applying the patch, it should look lik=
e
this:

	use crate::{
	    alloc,
	    bindings,
	    device::{
	        Bound,
	        Device, //
	    },
	    devres::Devres,
	    error::to_result,
	    io::PhysAddr,
	    prelude::*, //
	};

Otherwise, looks good to me,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
