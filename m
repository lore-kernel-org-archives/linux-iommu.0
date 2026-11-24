Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795543415;
	b=YMG/AZXf3qknk+kIqxbJ7qaFDVYMC0dxFgIw842Ls93KuW1hsycaOFL32ILE05eqHP8F
	 jTPxdGm0iYrfQrTI8Mn/7WShTlNTdWXGhq+LF7GOmSmA4hUUZYzZHBQYMdYA6fhNkjKqP
	 gL451I42qrGQ7wTCxDNr/xyXyPLcpUuseXV22cJfSKHWxdb+7fYMfGpx8/jNIANTStebI
	 QrcZYaoQEIRA7OM/c5N9cpDMJC9TUaZ7f9l8iMTcJlGWqz3ECKEVS7SrLDuMv58g/vz+u
	 34JzrEOXwdnPD2UpEsiEYVkjCfY92VaPXeDTduKT/HrR05VQ19B/f5J/LKqI0ZN/PUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795543415;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=NhTEfKWb6DbluRd1mldD3BYSLbGgDbbN8zaDAjpM6uw=;
	b=1ji9w/5YY7z4fbeFfbRMz3LwJsJznZML6Jl7yGxom69JoBoF7CtfmKb06Cgcs53M8+fk
	 mWjxGWqGNyahlEvWX2DcgHrCeCZfx3RoMKow9JYZJn8/5jBDJybm5801TXkdUHEuxfbqb
	 pRSbze+/HwjBxXYU95m9peDOYuskVgoorxx3eLR5zYzNoahIcDlqUWXX/Bn2Fqca4mU4y
	 05Ad6jLP2n1o0e//eSbgUcG6inhUubhv4IRqCIsT2jRrRcoaF+Nemff9AfzjFapaOVm9P
	 SGzJLHFaOLp7mh1GdRmiNgMr7xYWcVPaJ9ECEgt4Vf2vzQbvMo4e7Q0gpJWeUtUSp8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lAqaTRNM;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99423606A329
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 18:03:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 99423606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=lAqaTRNM
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1a2af4c8d00so2061824c88.0
        for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 10:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1795543414; x=1796148214; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NhTEfKWb6DbluRd1mldD3BYSLbGgDbbN8zaDAjpM6uw=;
        b=lAqaTRNMsaoB2X4JdnC5Ko+7kI5vulLvS0HoYck/rHL6NvYsqoTCws5qQG2u7RQ7Ga
         bjGXARD/pM+rmShZtxqsa7eylZaUt4nD792NYpwdeQC15sKf9Qs6IKVzeGPwS2+O+6mY
         +78FN1W8cRH4a1f7hGQ1/xquukktVdgrB2B8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795543414; x=1796148214;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NhTEfKWb6DbluRd1mldD3BYSLbGgDbbN8zaDAjpM6uw=;
        b=y+MK6IO/iLmRmytOd8OxY3gENlncU25sI+PZZQAZS9paxuy7zd+Ga6n9cSqj2BTBsm
         lHPcbc3u9OMpuZudn3qKVZ1tXLxsE7h8E+VHzL1DY4C7u1oSuMtzQBgIMEprVjCjzX45
         0qlOz3xYsWs8rIz0NurSEvjKtlVY+8Gm2CuAkCT99cGnqckam4Nlzzh6sRnRshJ5M0z2
         mZuHtvF/wx3Jw8dIRh9aPyuT9W10vnkR+Sggj7mRyve798dlw6lLJlfbCttshWbARMlz
         AGe0QgQ7bkhj+uk/rxhoqGCkBBSyEvVW4I1pF8WebfiGj/kQ4UDXViGdqfIAlZXi+1pi
         xoDQ==
X-Forwarded-Encrypted: i=1; AL+hErHMfmGXn4stzVQLS3zeguPCIcORFf1yw/mdlSrDxKykpjsmSoKelerClqdU698GozBqn/Kbcg==@lists.linux.dev
X-Gm-Message-State: APuU4Z9Kbgc8de3tMsALQKb9WciWi49MpTl2+m1d55JoPOsQc83CipnG
	zMFrIKeg4VKSQ/jJQNxXQb9f/Uq5vgF7rG5uSZj//GTkGLkf+bGtlP35wN5xd/L7lw==
X-Gm-Gg: AZFdTZfUJdmmz9Rd9yAgCA3BipZQxkgg3qztkuDpXDTYcjaib++bXrBWJejyI84quor
	1dDhxPjxjWvqaQDFB/FDXz4IkVHV5myiPtdrtLudJTX98smb2FrYL/lR2BL3CQjQZXz7+9aJtYI
	luQCr7m4ko5wcDq5z2VqwVGSGT7T6H83LLBZHICC5Y85zhiLPYY/+6He65MIvM3xx8bGog3INjV
	Cr3AasnLJhfWVdIlGYldnGxAMYjWu8yLSA28HzwyOFfFQ9g1IuT8dD60UIe0bNKC9CUVgUW5Xfz
	L9Lau09vGQB0plW8fYfFb+/4Vi2is6rWUIiv7HlZIwD2LWoSNcXOcEGXLa3YGRi2U6YvQYE5zbI
	ZytDcmKF6cTfT7W7UFTtYn9M77NxzyB4UIEdqdxaHshPeNhU42P6oPAa6Mz9eZqeg1oJ8gwZlyV
	k1xiI00aGoTBEjvvF6KTsFOlZGXYqJUw7xCJU4OPp262v3QMQ7scYGQMrNez/1+4IYOK1UZfw3d
	0Cg4dEnZUkTYBc18IQ7eGBj67vXbCKfuI0uAHLIiWNi1EmjWlxutliEiotMo2gu2w/vuRIKG0II
	btrVzE/o00SJzWqnxj3kYairfjIsCvr2Kl+1XeMif1svTj2QeiCgjQxqylE9OULpzMv9O0oZlwA
	wmtNDVArVwGRfZg==
X-Received: by 2002:a05:7023:a41:b0:1b2:649d:dc23 with SMTP id a92af1059eb24-1b556901b95mr16214334c88.35.1795543413661;
        Tue, 24 Nov 2026 10:03:33 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:6ad2:8ba0:aedd:5a84])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-385666e99fdsm58381434eec.5.2026.11.24.10.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Nov 2026 10:03:33 -0800 (PST)
Date: Tue, 24 Nov 2026 10:03:31 -0800
From: Brian Norris <briannorris@chromium.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>,
	Linux Driver Core Development <driver-core@lists.linux.dev>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>, iommu@lists.linux.dev,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Ulf Hansson <ulf.hansson@oss.qualcomm.com>,
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v1] PM: runtime: Eliminate __pm_runtime_put_autosuspend()
Message-ID: <awXRc5mqhe6h6MGi@google.com>
References: <13014755.O9o76ZdvQC@rafael.j.wysocki>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13014755.O9o76ZdvQC@rafael.j.wysocki>

On Tue, Nov 24, 2026 at 05:36:41PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> There are two users of __pm_runtime_put_autosuspend(),
> pm_runtime_put_autosuspend() and arm_smmu_rpm_put(), but
> the latter duplicates the code from the former.
> 
> Fold __pm_runtime_put_autosuspend() into pm_runtime_put_autosuspend()
> and make arm_smmu_rpm_put() call the latter.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Ah, it's about time. I was thinking Prakash's patches would handle this
semi-naturally eventually, but they seem to be stalling.

Reviewed-by: Brian Norris <briannorris@chromium.org>
