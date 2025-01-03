Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAF11C5F2F
	for <iommu@lists.linux.dev>; Fri,  3 Jan 2025 15:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735917545; cv=none; b=kF/jvwTLKEBeMSaWpbOCyXSITMKuG62TLxk6LHUY/S1fA35dapTLLP+slAccWWchBxkvRqwht8GVmpXknLfOi/t4eH3A03+kmW0BBJLux5V7qkLzRRUj1q+6kxuJYQ6xPk/7ioWvLxKJ4fjbxyzIxZVwvaICwOfN3HscAeqzpqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735917545; c=relaxed/simple;
	bh=CGB8nJCzb5yHLiu2JB0xT5s1DN9ayx5bmIexjSS5sZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RBNkpuu9VstfV7ft3dKOoycD9sJHbD6zYJnM4zMh51AJo8Z4rWp71SiBbu7Ys+K4COYN4ZuUsK9jqMzqgW4CEXgovas+fhF5EY9E6YZ35tSxkIlxKsVsy4GXOs8Byq2yxopuiN91RKGuEN9alzWv5ZjxwPO3EZC+jCLS/DIG3W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=V8haeBPc; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="V8haeBPc"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7b6ed9ed5b9so1700967185a.2
        for <iommu@lists.linux.dev>; Fri, 03 Jan 2025 07:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1735917543; x=1736522343; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CGB8nJCzb5yHLiu2JB0xT5s1DN9ayx5bmIexjSS5sZE=;
        b=V8haeBPcUhdAD+wq/I8k/pnVYPcuY+elj8Fb9YaGX/pL8ENo9cLMjN4z+2/CejqBB/
         Q/8ft5/ZNj8F5UoTy1gBUb6iKXLNYpROYy4QS7iKxvv2KPbDuWCpUA3g3rNEoS2cJH1h
         v95AwOmM7BtdPkvNJgrRVQOINrTKHyRDUpnOmPa7JIcEuHnopF0yAOicYnnNShKuMkwJ
         /NSiFpImH5Wjudwak2vmdEoeTncKjW4VrqrmtLGc58gnKkeOAUUuwKwfhfay0F1DSizH
         HbN9kMQDSt9NOmM67fCpoXhKuRQYW7CdfUA281VoECXH9P/ZsaRm7gfhjiGJCvErJqcH
         T2pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735917543; x=1736522343;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGB8nJCzb5yHLiu2JB0xT5s1DN9ayx5bmIexjSS5sZE=;
        b=g2kC4ZnNeKgdRxox/qlKP0lsv6xxJEpDWPGbixJA/mQmDYEFqGcak1pCUv/WFbOCR0
         zlb8z7a+RkAGPSPApJ8F3ptakMXY+M9aQz6MLqvpGaiLke54Gs8/jZXsVE/JB2jSBkUl
         hP/9xgEx+git4NRi0MmsSE3DDxtYHi2MJDkYirQjC2N9e//ANHOnh0OvdwJ2F9xMC+pR
         rt7d6E2cOtu5VMTWCCMok/Knmy5irbzHu+4tx89oote1i8OAg0xjpZ9HJsHBryPQz9MS
         XZWItEYCVYg5A0R/Iz4bY8K8Tq00kw4H5FjtFw7P1GsN8WL5NNTXQnSVHmTO1csPzV7d
         2JYQ==
X-Forwarded-Encrypted: i=1; AJvYcCWy6JiJea+sX3NeYAU/dHBeGUSvZtsqscAnXx6iEAN+U67MlOjg24HdMQqNLCJvnmmWKe6/qA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyyBshSLTPI5V9cRXme6JGTxsu+Ae22RsuFqghu8M1vjaLhSINe
	pLuKgNv8MaVFkylk8HZzBeVktjB9EVo3Oz+phjcJEgHXNJuNsuD7oaaFCICfTnY=
X-Gm-Gg: ASbGnctNlPyP8omZN44ZlEAnNqxS58QfKoUAXixik7JHaTDWQjvOY+q5UMsA+Bd70PM
	cmbpU1X0ka5CQPSPMudSRlEzGag07zYBjwFVStE5ZDK6ldWOemrpIDFS/iahA1qjQQtDSYCj09f
	H5hEsRiP76NScVzj9oD38iH6XaYvGat1yG7d/CqpyvUCXDXclwTu2my461vhR8xr4XlV7XFS0lz
	A0p4cOlmodMAc8DFoBwKCknmE1lRgR0Hsh6VoxUPsSxOgjshC+uKocPT/HFUHhNffcHbrA89+FP
	yNsdrQBgxHdYCy8y9btfWBXSxmDrMg==
X-Google-Smtp-Source: AGHT+IHTG+Bq32SHg17tHpm9vXIkHAkuaGHUCVV1avASRsb7eSYGQtc9W1/GwgW3NuW7igfw1fFU3w==
X-Received: by 2002:a05:620a:488a:b0:7b6:d5cb:43a9 with SMTP id af79cd13be357-7b9ba773db8mr7230744485a.23.1735917542951;
        Fri, 03 Jan 2025 07:19:02 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b9ac478f0fsm1277723385a.71.2025.01.03.07.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:19:01 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tTjS0-00000000iwx-2edn;
	Fri, 03 Jan 2025 11:19:00 -0400
Date: Fri, 3 Jan 2025 11:19:00 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Alex Williamson <alex.williamson@redhat.com>, kvm@vger.kernel.org,
	quic_bqiang@quicinc.com, kvalo@kernel.org, prestwoj@gmail.com,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	iommu@lists.linux.dev, kernel@quicinc.com,
	johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci: Create feature to disable MSI
 virtualization
Message-ID: <20250103151900.GE26854@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170014.1583783-1-alex.williamson@redhat.com>
 <20240813163053.GK1985367@ziepe.ca>
 <87r0aspby6.ffs@tglx>
 <03fdfde8dc05ecce1f1edececf0800d8cb919ac1.camel@infradead.org>
 <20250103143138.GC26854@ziepe.ca>
 <432d4304b579c5bd6973628c3c4aaad476627f7b.camel@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432d4304b579c5bd6973628c3c4aaad476627f7b.camel@infradead.org>

On Fri, Jan 03, 2025 at 02:47:11PM +0000, David Woodhouse wrote:

> Probably best for the hypervisor to have some way to *advertise* that
> it's handling this though, as guests also might want to run on
> hypervisors which don't.

If the hypervisor doesn't properly virtualize the device it shouldn't
assign it to a VM to start with :\

Intel looked at the question of advertising clean interrupt remapping
when trying to virtualize IMS and it didn't seem so great.

Bare metal machines need to work, so any test they could think of
adding would either fail on bare metal or fail on existing VMs.

VMM's have taken the approach of not telling the guest they are in VMs
and then also not implementing the bare metal HW behaviors with full
fidelity. So we have no way to discover that the VMM is, in fact,
emulating broken "hw".

Thus we get this push that all kernels need to accomodate the worst
VMM behaviors :(

Jason
