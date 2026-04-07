Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7131C3BF7
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 07:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775546405; cv=none; b=eXDoNZFQ4QjJ5AIuwPBV5V9EQlu6tn9NWzEVas6Hnwi8QFEAcahSqs9S2hmWrwsHnhjpeBQf/vs2+cYeVxQZTHtn3mWG9lyeHkGZRsAqk8uHkgxSYiuGguZxZ6TsHGQ/ut7Ou8Hk9vj1tH4wdU+i/gxnYZF/jrc/T/Udi0IRhIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775546405; c=relaxed/simple;
	bh=VGXIjtQ+zcgpDmjQnxagz2doQwln72F27aRoSrmUNjQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r+WNHv+Sd2m8z/nDJGKVd/PXxMczdyWgpRSIz28c4/tnbQV6A+4HCWGqWiNUUUXIEi9DBKAu6c8/lgObjgWiFFz9LNXiM/pXnX6cYI77Or/qIX+Fm0TjdPqvwKF2bVFrcKefI1o7e2yUXHtuzte+MPx+yYjJgkqn1bqVSdNaams=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lUYgV56S; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wnliu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lUYgV56S"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-1270dcd11c1so8072056c88.0
        for <iommu@lists.linux.dev>; Tue, 07 Apr 2026 00:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775546404; x=1776151204; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VGXIjtQ+zcgpDmjQnxagz2doQwln72F27aRoSrmUNjQ=;
        b=lUYgV56SmtKwvkbXzc94Ynp5jrNKaDzHTCEgC21P7b2mvI7MbXC4GKc/ZlpSu21DKt
         YSFfpuj7eNRUF1W2p3lCkCyNJwngdbnxYgPM/EWm2tPxo3bG9kI8rTWW0govxfp3vPkT
         +ymZSSZlRTfHy1tArX/HrsPximj91dKGWxAXf7avziF4qneBkTKLAfjHkNYWTKj2tOBX
         FxgFX0amS7rFQX8Y3U3IF6GEOa+ixDluJF1/gQZ+Kwf38362OrlNmQRSLWj8EgFhNCsV
         eabXcbdJUaG/JCAbOdlpicnBpD4m9Y4hXlQCgIEsga4u40oN8A7NPBZZK0HaD3YhhbTK
         Rgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775546404; x=1776151204;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VGXIjtQ+zcgpDmjQnxagz2doQwln72F27aRoSrmUNjQ=;
        b=tXsY5qxyIY68Naku/Kb8h5u1m4CjwMN5kuIBZiiYk5LfEdxDSziqo70BdDTmc4xbTW
         8RdkD0OEGv6vV4VI08N6Wred5S3bEU+7EVslLDaDxUsg+clwKXc2wR0IrU9WMse7RC2t
         6XnZX5NVh3bY7zAwyIFDLyhb8qOk6HaTU2WjBJvOZ3fFU/4KG8RtCFx3ieESIrVdvnuC
         r6htHSXXPtwJ+R7U/MO/CmtJX2A9uZHo3QeNrxJDvEaXb2BXwyhzVzwZTH3wKTzA7/0t
         SBTp7RUXzPfAYwCrOFds6ZqS/o05YZ2WxaM2X3OCx4LMprLCe78I04kp47tSPMAwkU4p
         3QnQ==
X-Forwarded-Encrypted: i=1; AJvYcCXXiUpHvejYYHzmFCDRIwhH4tbaWIV+R9ObY2Fss5jO7draKTqsa5Lvaauo3qWdIKYv+Vz3aA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwpxWieGh1g0j058FkcYWwjbXqdR3Jcb3tKvimqajXHn1mX3TQC
	TipdKJLSZSz/OYxM3+b73MtPwygCXulpGy4b1+Id6eWtyrwLvp3tCiZwR8YNQt1XdfA7ezkOERS
	2yA==
X-Received: from dlbvs3.prod.google.com ([2002:a05:7022:3f03:b0:12a:7a40:ea24])
 (user=wnliu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6997:b0:128:cf75:42a3
 with SMTP id a92af1059eb24-12bfb745b32mr7158994c88.21.1775546403614; Tue, 07
 Apr 2026 00:20:03 -0700 (PDT)
Date: Tue,  7 Apr 2026 07:20:01 +0000
In-Reply-To: <20260330084206.9251-9-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260330084206.9251-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407072001.638812-1-wnliu@google.com>
Subject: Re: [PATCH 8/22] iommu/amd: Introduce Reset vMMIO Command
From: Weinan Liu <wnliu@google.com>
To: suravee.suthikulpanit@amd.com
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev, 
	jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org, 
	kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org, 
	nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com, 
	vasant.hegde@amd.com, wnliu@google.com, wvw@google.com, yi.l.liu@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 30, 2026 at 1:43=E2=80=AFAM Suravee Suthikulpanit <suravee.suth=
ikulpanit@amd.com> wrote:
>
> Introduce new IOMMU commands for vIOMMU to reset
> virtualized MMIO registers of a particular guest.
>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Weinan Liu <wnliu@google.com>
