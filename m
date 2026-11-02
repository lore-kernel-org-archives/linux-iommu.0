Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.149
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793654921;
	b=fOiNT3yPQumvbKIhomg3tO6KnRaCXlmw+3x7vjv6ilp4TNUn56/C+MOKQCDXLtfU+BT0
	 8/z+XobY1dZeU9OSgoAZ2evo5cs61N5hIcBGzawysXiQR2Ii5WM7vH3NzLnsIIMOy5V4x
	 fP2Ck+c+uKlfjBlwCMLia6XEPqE4QdvcJ5/+fusqvFE9SQER91C4dTp8BiD24Eq1g65yF
	 Xh5usmwxIvINddZulHcD/jAgoe89n0znWyIz2ggfyXrbB1Ej2Mpkt8zLVqVd1LOxS/iiS
	 DLwX2t/tkjsDmoxgBz90Nb0X9bMpOTltnkj25T3Vg+WsUDfojA4tmqDZdM3vTDJF1pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793654921;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TGm7htG/ot06XVnjyNlWivSivtfZ8/BMdXWpNsPs7Uc=;
	b=lRVY1uJFePG0VxpmZOy0RvUlI+0cPJPABLwveXBPvCyN5ZzR8/BIHYeo8FRhP1+aCSW9
	 G3jJTAtFHfvJJV1IZldaq7g5mZd4+PHMrvunJTYJfmNRl1PqSqMW3MxaGwRlMdlwwjkTg
	 2XGXoIANr+h8zJNaqGxCqPykyIeDJ8s6T1A5s0LeAGYUeFxXbzbEVFrUUOOY7G/ECiARU
	 7/ehLRzXfpKlcEVSglNgq+zzLdQgv36TKXa92XNOFt8rY3WgmZTvqfFXOIu7qli+koGRm
	 KYNAQIIMpCq5yAkDAwHKUcFr8CMv2PT+lBqaJv2eMQuRfphvKjh4XKODfMicj1m+oCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=temperror header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b="QXwOH/vh";
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HH36+inY;
	arc=none smtp.remote-ip=202.12.124.149
Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8F5606A32D
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 21:28:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F8F5606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=QXwOH/vh;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=HH36+inY
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9DB551D000FE
	for <iommu@lists.linux.dev>; Mon,  2 Nov 2026 16:28:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 16:28:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793654913;
	 x=1793741313; bh=TGm7htG/ot06XVnjyNlWivSivtfZ8/BMdXWpNsPs7Uc=; b=
	QXwOH/vhIXfDrZu1Qk0CXDGEmKgZr+WwAzEg+cvHEXzetsuX9JdR+BdqRSuKTid4
	Vp6RJ6SHWh41j1555UWZWGqftlT6lmGsfqm5lVvaoBkehPj84W0LcqH8krim03Aw
	2GRZ+hcPUrIpcBGVtNXW/1GTQWi685KoY8dLM62sJU8SidG0/lYc8zWS0Jqrpc4y
	gVuThcfHE9YlGhBn02Y0aV24YDUilm0XuKpmNw4e1tIPOLyCxHBBzr7dr+P9Fqd8
	+x1V4IvCdMvUf1EzrLbC1Gw+Q2OBvAqXzbN2n2pc44dreYCE0jE0IJ7J6FOG+nLq
	oNCaOAnGF9vqkVwZQus+9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793654913; x=
	1793741313; bh=TGm7htG/ot06XVnjyNlWivSivtfZ8/BMdXWpNsPs7Uc=; b=H
	H36+inYiqZpVrJhWM4r4Set9S7Y4ecVfD3KC9SBzFOeuIATeMgTNSZe1/VUhrhRl
	l5oAehtsBMUbneRsAFWQm47S0abvQhhbVR6m1qf7RxL0GVEH8dnT5ob8FxsPQ0SU
	A1ri3f89G13AGaonzDa2Bqt1vw4d6Fxn+JMJWfU1vRCfYz7SgIBnNQj33mc66Fez
	C76AEZViI0DlkCzdPh3jrj7IFZeSRukAuky52tEx3sVuwUmFI57OGKjM5Bv2ASQ9
	hgnLA4Xd5B4N1WuPj2ScXvw6UtUcNhvDgKg8gWvobCYh05lJ/RFOpyBINHP2ZZXO
	sMBNwIjtrq7kDLXnAyyrA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793654913; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PGlvbW11QGxpc3RzLmxpbnV4LmRldj4=;
	s=fm2:rsa-sha256:uac+MN28rI+n84yuXgN6iEJ17ph5C3KKqMKG1cNc7v82m6G
	VH8UI1p1jRpcRUWgLzDNiBjo0U4QY6DKAbBwNuSIIOUMCUy9+ParCk/6gJ0LQ+eQ
	fM3VcjBoX7eHFTarWFBH82Rz+ZBmOGUZhzq9BK6LiVfHtBAEm1ETPbRTq55+u7hq
	Nb7z++nwbl4SITvMYf9fKuoYx/81jjWtmfecNWG9oBe13JydCUKByrbgKVcs/rs6
	TmHVcroCByISlDACyMMtfUbS3MG3bz+Hv+TKyHJzDnYbDB6350IWjC/dKOOWIwyt
	Vbs6hTtI5cgNpd+zCf2uA4dFoO/HPugN3a974KA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:fQhjXTHMSCFYw82lY+M39SpFziaJ40laPfR8sjV9ybc=:VH8M0/nV+qAehY48+/GbRvb8YZKsrkDGqiOxbaCH9ik=;
X-ME-Sender: <xms:gQDpaqYkap5dV1xYYNADSvp4Z3UNhjDNSABOhEieUdidqhs-O8e6TQ>
    <xme:gQDpapa83m0I5gvdO46VDbmb2EfL0pDKK7nRpkDexLegaBgc9pMSD51r2y08buktn
    p7p98c5EZWNpD_Y5ayuvr3J6e8akUsUSQi40hYcBL5RR-8WyRjotKI>
X-ME-Received: <xmr:gQDpanJgUFbHZJ8g0bcdKSJFkZy7_6o0w5ber55-us4st-mwBFS4h3PiwmfKgg>
X-ME-Proxy-Cause: dmFkZTFaV+nXhVHS6u0I3Y+aHKbNt6XALkJlLTBxMAabrrMdV5swgz6nfNQeankIE4dplL
    LR6XkZiaMnvltcX+zyCbZ/oNz4dopBkT2ix67Uk6FdBOB1EDVE3SQDs07ZfrQFHhUR39py
    /wwMJDDKnpXDxMZXp0dy73waqetBx4SKOPOAb62nCDyV1Zn4inenhvmC/Om9mledTlkx0t
    Pgi1p/YXbomzjqB7spBwHngbXpEG+IREMkqFw+vUSN/b2InXRHhoNBRfl5FMed8HJoUA3j
    gV44Ci8CfEA/YkPfxX7IAn/zkr3AYtuuCPiHktW6lw4uNnf1BUjZ1jyfJYqM7SAsQsbyjs
    qwoybRBeAuUeNEZa9+VaF50ftTC+dNauZCIyfdb7vzugHnJPlujkhcaTEh4X5/RqimjiF+
    yeFImqTOz3TW+4A2nODTuIn9Mc1+FJVMiGXaLrZMi3wBF/Qn9Or/bLOkYhoqSlDE+SvATS
    VxjDAyej2l7uv8SlufK/+8m2D+4Bx8v1F5y2EVl+KtO+onRrOolmiOWL2I4aBeGIP8N/6u
    OiW4Rog6UdRa2OWjoHKyYVHRZlSVYdhcFGDTEurTrRv21sxdXz/mviz3HtFe9HHzzUxXwW
    MNjPbK/RU5mHR5WqWI5RoNABfq8lZ7NimBDHjX9Z62ovYDZytxpLNknzCigQ
X-ME-Proxy: <xmx:gQDpattcq-4Rt1y3w2gdouMexBSCcf2rHzhABtxastocGZ7xefxZeg>
    <xmx:gQDpajUgZZ-BBuAoKzbw77I_rPYeUCb2O2Kii7v3Tt9WwbVgqihphQ>
    <xmx:gQDpaggKZ22ohq8vIE4znStmFqNNFrM8ie4cOYCmEvpWXAkUs3QZWw>
    <xmx:gQDpajqlwtiOSwvhk4cddDc8QchfPxh1uPPf8TbugLJFaDd0t3mOFg>
    <xmx:gQDpakRHb22PhEfHh9AJ4g4BbtSffoPZXELItrMuJd4EkIfK_QL8BMvg>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 16:28:32 -0500 (EST)
Date: Mon, 2 Nov 2026 14:28:29 -0700
From: Alex Williamson <alex@shazbot.org>
To: Kyle Zeng <kylebot@openai.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Kevin Tian
 <kevin.tian@intel.com>, outbounddisclosures@openai.com, alex@shazbot.org,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
Subject: Re: [PATCH 1/2] vfio: Publish the container after all fallible
 initialization
Message-ID: <20261102142829.3e2018c8@shazbot.org>
In-Reply-To: <20261031042527.6418-1-kylebot@openai.com>
References: <20261031042527.6418-1-kylebot@openai.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 21:25:26 -0700
Kyle Zeng <kylebot@openai.com> wrote:

> vfio_group_init() publishes /dev/vfio/vfio before vfio_init() has
> finished. The optional no-IOMMU backend is also registered after the
> misc device. A concurrent open can therefore obtain a container while
> the module is still COMING, even if a later initialization step fails.
> 
> The failed-module-init path frees the module without waiting for these
> open files. misc_deregister() prevents new opens, but does not revoke
> existing files, leaving their vfio_fops and callbacks in freed module
> memory. An unprivileged first-autoload race can trigger this by exhausting
> the global task limit before the IRQFD workqueue creates its rescuer.
> A subsequent VFIO_GET_API_VERSION ioctl reports:
> 
>   BUG: KASAN: vmalloc-out-of-bounds in __se_sys_ioctl+0xaf/0x120
>   Read of size 8 at addr ffffffffc089df70 by task vfio_race/1484
> 
> Move container initialization out of vfio_group_init() and make it the
> last fallible step in vfio_init(). Register the no-IOMMU backend before
> the misc device, and unwind both resources in reverse order. Once an
> open can reach vfio_fops, module initialization can no longer fail.
> 
> Fixes: cba3345cc494 ("vfio: VFIO core")
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
>  drivers/vfio/container.c | 22 +++++++++++++---------
>  drivers/vfio/group.c     |  9 +--------
>  drivers/vfio/vfio_main.c |  8 ++++++++
>  3 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/vfio/container.c b/drivers/vfio/container.c
> index 003281dbf8bc..bd245e23a55d 100644
> --- a/drivers/vfio/container.c
> +++ b/drivers/vfio/container.c
> @@ -577,29 +577,33 @@ int __init vfio_container_init(void)
>  	mutex_init(&vfio.iommu_drivers_lock);
>  	INIT_LIST_HEAD(&vfio.iommu_drivers_list);
>  
> +	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU)) {
> +		ret = vfio_register_iommu_driver(&vfio_noiommu_ops);
> +		if (ret)
> +			goto err_mutex;
> +	}
> +
>  	ret = misc_register(&vfio_dev);
>  	if (ret) {
>  		pr_err("vfio: misc device register failed\n");
> -		return ret;
> +		goto err_noiommu;
>  	}
>  
> -	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU)) {
> -		ret = vfio_register_iommu_driver(&vfio_noiommu_ops);
> -		if (ret)
> -			goto err_misc;
> -	}

This looks wrong to me, an error loading the vfio-noiommu IOMMU backend
shouldn't cause the subsystem to fail.

I think this is fallout from a13b1e472b93 ("vfio: check
vfio_register_iommu_driver() return value") that had no other
justification for inducing this failure than the fact the registration
function can return an error.

The error return is necessary for the module init use cases, not here.

Unwrapping that as an unchecked error avoids the re-ordering here and
in vfio_container_cleanup() below, and this unnecessary unwind
collateral.

This should be a separate patch, and use the correct lists per the
MAINTAINERS file (mising kvm@vger for vfio).

>  	return 0;
>  
> -err_misc:
> -	misc_deregister(&vfio_dev);
> +err_noiommu:
> +	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU))
> +		vfio_unregister_iommu_driver(&vfio_noiommu_ops);
> +err_mutex:
> +	mutex_destroy(&vfio.iommu_drivers_lock);
>  	return ret;
>  }
>  
>  void vfio_container_cleanup(void)
>  {
> +	misc_deregister(&vfio_dev);
>  	if (IS_ENABLED(CONFIG_VFIO_NOIOMMU))
>  		vfio_unregister_iommu_driver(&vfio_noiommu_ops);
> -	misc_deregister(&vfio_dev);
>  	mutex_destroy(&vfio.iommu_drivers_lock);
>  }
>  
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index b2299e5bc6df..dc8f8a38723f 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -898,14 +898,10 @@ int __init vfio_group_init(void)
>  	mutex_init(&vfio.group_lock);
>  	INIT_LIST_HEAD(&vfio.group_list);
>  
> -	ret = vfio_container_init();
> -	if (ret)
> -		return ret;
> -
>  	/* /dev/vfio/$GROUP */
>  	ret = class_register(&vfio_class);
>  	if (ret)
> -		goto err_group_class;
> +		return ret;
>  
>  	ret = alloc_chrdev_region(&vfio.group_devt, 0, MINORMASK + 1, "vfio");
>  	if (ret)
> @@ -914,8 +910,6 @@ int __init vfio_group_init(void)
>  
>  err_alloc_chrdev:
>  	class_unregister(&vfio_class);
> -err_group_class:
> -	vfio_container_cleanup();
>  	return ret;
>  }
>  
> @@ -925,5 +919,4 @@ void vfio_group_cleanup(void)
>  	ida_destroy(&vfio.group_ida);
>  	unregister_chrdev_region(vfio.group_devt, MINORMASK + 1);
>  	class_unregister(&vfio_class);
> -	vfio_container_cleanup();
>  }
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 423ead48aafe..dfc48a9e0fe6 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -1852,10 +1852,17 @@ static int __init vfio_init(void)
>  	if (ret)
>  		goto err_alloc_dev_chrdev;
>  
> +	/* Publish /dev/vfio/vfio only after all other fallible setup. */
> +	ret = vfio_container_init();
> +	if (ret)
> +		goto err_container;
> +
>  	vfio_debugfs_create_root();
>  	pr_info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
>  	return 0;
>  
> +err_container:
> +	vfio_cdev_cleanup();
>  err_alloc_dev_chrdev:
>  	class_unregister(&vfio_device_class);
>  err_dev_class:
> @@ -1868,6 +1875,7 @@ static int __init vfio_init(void)
>  static void __exit vfio_cleanup(void)
>  {
>  	vfio_debugfs_remove_root();
> +	vfio_container_cleanup();
>  	ida_destroy(&vfio.device_ida);
>  	vfio_cdev_cleanup();
>  	class_unregister(&vfio_device_class);
> 
> base-commit: 70dd4ee72eb2d5793c62e71c14e3aba78e5a4e56

Jason additionally asked[1] whether the try_module_get() via misc_open()
-> fops_get() should be the real barrier, preventing open until the
module has fully initialized.  That seems a valid question here as well.
Thanks,

Alex

[1]https://lore.kernel.org/all/20261030120845.GA3889730@ziepe.ca/
