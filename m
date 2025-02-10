Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD341C174E;
	Mon, 10 Feb 2025 09:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739178566; cv=none; b=Sv8A7vJrls/nIAwjUz7LdR5MxipJS58QKKw28hicdz6bv+qgAmtBfs62q5l9wsyiZxt0sS0QKx35FlE7eeET6oQcaaV+qayDetgKa0AvGAsjhRJpVgenCds/r6vfILOVBkhGdRXCpIWGcgPT+ChL0LB2WbwEJsq44gX4nR3lP1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739178566; c=relaxed/simple;
	bh=evgPDVEHq+i5ebQ2Dc4JO6fYbp9JdbG1rABL14Tj/SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVHQ3L66WJOC5hZTlBvqg1SSWeZ9Hy6xZiXNKfn6tADGbJB1rxczKbMupg21UjCXVw4Y/W0WjB+4Kmqpfggjtx4CdfudFdWF6fiDPf6/sipJuEKtXb17EHsklreVBwhwNWd13+oJc0k5Qt8VofH4YRxwqug+FTKeP/02FPj/5Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EsMk8Ssu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EsMk8Ssu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E041C4CEE4;
	Mon, 10 Feb 2025 09:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739178565;
	bh=evgPDVEHq+i5ebQ2Dc4JO6fYbp9JdbG1rABL14Tj/SE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EsMk8SsudzdlH3QeH7Mor+prhQ9xPpFYuo9RDV6S95D1LiEGtumha8uE8JR+8uNT8
	 3spTenlsDAxMqnWRiDf4jotippCShJ9TpbaCpbxJSjp/sPVtAfP8PEuQpRluOYtlXu
	 u6KJnzc6Sp3NmhLz7dDjGw8Fy6XDIYaUyYUnXsJFl9eQeGL7Sp+v0ZeCGAQCaV7tmU
	 E/XYxNv18gt62/uJOUWaiL279VshKxyd+AwpuchPhYAUFLXjK0TE0f748XIC+W13jJ
	 xgjudqBYL3ADXUFcjq7pNkEGKdcNX3OWKNOTKlGEr2u4EsokxxhVriilt/sNhv/Bmq
	 RMS+jM/UKhn3A==
Date: Mon, 10 Feb 2025 10:09:18 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Pyrex <economicsbat@gmail.com>
Cc: abdiel.janulgue@gmail.com, a.hindborg@kernel.org, airlied@redhat.com,
	alex.gaynor@gmail.com, aliceryhl@google.com, benno.lossin@proton.me,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com,
	daniel.almeida@collabora.com, gary@garyguo.net, hch@lst.de,
	iommu@lists.linux.dev, kernel@valentinobst.de,
	linux-kernel@vger.kernel.org, m.szyprowski@samsung.com,
	ojeda@kernel.org, robin.murphy@arm.com,
	rust-for-linux@vger.kernel.org, tmgross@umich.edu
Subject: Re: [PATCH v8 0/2] Add dma coherent allocator abstraction
Message-ID: <Z6nCPppxZEr-mlGQ@pollux>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <b968d31a-b63b-4d2e-be6a-030e323aa7e0@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b968d31a-b63b-4d2e-be6a-030e323aa7e0@gmail.com>

Hi,

On Mon, Feb 10, 2025 at 12:54:25AM -0800, Pyrex wrote:
> I'm nervy about the Rust code here.

Code reviews are always welcome!

However, please make sure to consider the following.

When sending feedback, please try to keep up with the latest version [1] of the
patchset.

Please send your comments inline keeping the relevant context and removing the
irrelevant parts in your reply. Otherwise it is impossible to have a discussion
that everyone can follow.

Thanks!

[1] https://lore.kernel.org/rust-for-linux/20250123104333.1340512-1-abdiel.janulgue@gmail.com/
