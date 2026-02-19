Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00CE34E750
	for <iommu@lists.linux.dev>; Thu, 19 Feb 2026 17:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771522487; cv=pass; b=UVRKR2OSPy3JCmgSbnikMo+730sSXlIStqJVllWeM5rGxGECQRE4BZo0DSMG0UgIIu3ospOPPRwHHs8d7BgSZ5H9ctKSBLs2lmgjNc1ewLNfArpRgd4Mt+G4mIqrTUrPb4ZQKW7GOX1RRqhk6VKeO0pa7dJ4tcQNA8c0J9eIjwE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771522487; c=relaxed/simple;
	bh=Nhfo6WowGFqZTaUMQKHqG7rfam1cmV6bFODpXkitYV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TzqWVOCs4BB80debvD3TMhaQe8dtgmt54hZ55WQVzBYNpyuC46yy+LQljJ4skkChZinoDYPPGOAIi3Q+9gZG9pp84bwb2W4F8TGRFC5lZrMspmbMY1NxpXBVOHGzYGCmmoJECJnEzBwudOsMyXsG6uwLJ4NM+U/mPON7M8G1JFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b=bvvOf8+Y; arc=pass smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20230601.gappssmtp.com header.i=@amacapital-net.20230601.gappssmtp.com header.b="bvvOf8+Y"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so1127723e87.2
        for <iommu@lists.linux.dev>; Thu, 19 Feb 2026 09:34:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771522484; cv=none;
        d=google.com; s=arc-20240605;
        b=PbcqMCEzyhSnSwFKq2Zmnl69RDMW+5SnzPztjazXf9qQ1RCJ3Sw25Mm4ozmZ0DvJEN
         8MnXluYYFur9cT2PqS6TegiQWyyPkmhfhuNcdaPwNdVTqStokzTPGI4EeTfJMm0ILaeY
         Hz6oLTtAaeARyb3U2veCbTGVV/ZH2ez83RFCf8h4LzHXF707QsJTW9BjoBkw1+U9YRQN
         VmRDyXwUK6HyfoqSeAvCWMwsEkrsNqdLNeBRgb0ZZRZP+GRd+MtPwTOTcskFNLlHhDAs
         lP6gdG0MFjhVZeMMCi2UTaXiep9qoOr5x68N/bX9Vg742sDuV1GSlsdAk6CAC6/kWkJb
         S9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UUE/Joru8hXMHvDVf62I8TaujuFRVcwhp9CDDO4vFKM=;
        fh=yBQxrNklSLcrkfR6XSkGCmdAr4Ww6hVSw6iTMuVS/zQ=;
        b=DNwA2QdOVzw/iCusOXLge1loSDrPPqKCYIkshG9HP8k30Te552rqyjNOlPbicLmmKV
         T9zenIsU7fsTp5p2MyneT09yDWPBCQpi1R3/sLPKfSlbx6gSwB9IG4PEr8UUd8Q+Xz+d
         DhEg4XsQUt57wL3i2sOPtsi8yi7IoOzxLpgObidi514PidZsOjKr8jIxFPTxVK6xg48Z
         ubc9JtnEUs7BSsFIL+jsU742VFgQepuLixlskh+OvU1chT9JK4lnAB5znc3M0VTZxkV9
         nIvEEJ4D+7zjyL5JxLk4HYCba4FvF/T3vfb6gGXQpiyaaLaOpHGkkkc/a+grgFKPKQ/y
         +pdA==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20230601.gappssmtp.com; s=20230601; t=1771522484; x=1772127284; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUE/Joru8hXMHvDVf62I8TaujuFRVcwhp9CDDO4vFKM=;
        b=bvvOf8+YSDidNpkNKxilL5Hlidnf0+M8GL+VyLnKkuZQSAL8u7X0OCOrc6yFniggjl
         UQ4nPsD1Dk30iA4p4mYhDRunAp4TIubKTjcCrs2Xt0Mbd8P1uNSWLS8azxErYRRlzrqN
         AO8ViL9K1nCPilzh83oG6kOBUH1MMyftxA+Ox1m94PlST9aN4TX7ARztTpdNVg/bi5gr
         EGzXysWzY/2dBF4/j3yVUdaAW/BPhWMkqQzU3ekwqN27E0uJcMQam5hhff4K9nnvR5z7
         h7vBRkpheqd+BqWX1QZkeBCmg7xcdKYyN2Y7cAzy13cJKJkMVqnRWs55lLmxgPhOeyKk
         lV6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771522484; x=1772127284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UUE/Joru8hXMHvDVf62I8TaujuFRVcwhp9CDDO4vFKM=;
        b=u5bjjQY1QDqf1D698vAh/sjjQGClpdQLB76Kgi78y9RBSmRXfeWiPbw1BcCOzSxXUi
         tR+a0MsHKrSAHUbnkPLloEhQW0CJrLS52uwkQB4vO5EWRHnlXG2z6LJHbqkxplFIy/4A
         RfogrWdSmtR1m/w/t2Gdn7cKD9ooVK7M9m2VGUR6HTG4b+KESvkGeOHvLo2Nf8MM0GBW
         yku2bfcZMzv6WdlBGXyM5SW8eLplpSz0CFx78/8/7yPRy3CuOZntMoUVju/a8+esXD+t
         6cVSs9lPjxMcEBaOIGDeuAIsn5vHtOuPSmhQXvbGwdK33EJsAHWRoyrbrWs7Mg86bfLh
         994g==
X-Forwarded-Encrypted: i=1; AJvYcCVl6++muWwgq71BrXNA981or9woK4QG31KjDrcI9xTmTnQdKuUH4JUsoUBRTkfNgdJuyIeczA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy3iPD+mbDJA73XllUFb0QlLz9Z6m/Pq4Y1ruEwSa2pH9kNya9Z
	CT/dPX8JjDqXKkn7NAz+bf48Pi2Su/Xtq0cp24AV8tGVeLJfPiMkt9QPgU9lvGz9LaQFfDo+TMi
	K9117LN9zWEKvn9Wv0m5lZn1PocmtLQtDuy8dwWUP
X-Gm-Gg: AZuq6aJJWWTcLcleaBbLp0K+ANr3jXHs2dshg6xLYUoGn1u17sKDNJD684QVxUrGap1
	CSx+0xJQBElTUzOSFlofisdvUhCwNJ7MjfMlEGsJPsgIzY5SOa6JS/8V7ejAhoBR7Hf3Rn+UUkE
	CtnApd0+Gh2zkQpM2t/eRA4F85p+3JiCyULhp9RPD4PxOr6HNnXrkfAFLPg6IvD42K6ryMJg/jF
	9fnA1QEDWE4AQTTqEzTpMG6JTnjxCSVv45UkMxl2p4SHv4VTUljoUkT72ddtnLi++jXfQmlniD5
	rfSC
X-Received: by 2002:a05:6512:2242:b0:59e:5e07:17fc with SMTP id
 2adb3069b0e04-59f69c28542mr6061794e87.18.1771522483387; Thu, 19 Feb 2026
 09:34:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251215233316.1076248-1-ross.philipson@oracle.com>
 <b5f2b5a5-b984-4ed3-a023-c06d634f9146@app.fastmail.com> <1ffd3cb5-2c76-4371-a067-3e4849907d80@apertussolutions.com>
 <49d169bf-0ad2-49be-b7d7-fceb9e7f831a@app.fastmail.com> <CALCETrUE8c-dxRWhtHKz_PojwZuWMXJSzOsFQf2vt5LS3ATwpA@mail.gmail.com>
 <1BBD7449-8420-43FD-930B-A4E1BA38FFC6@zytor.com> <CALCETrWzG1Mjb-RcwLQ5-tGFZ15WKHjZbqtLvyif+UPuVKJ_5g@mail.gmail.com>
 <32e62cef7b89d9691bdd4120388ce752fd041230.camel@redhat.com>
 <CALCETrUMR0RvOFXGzL7=F4c-3veL+1Sm2xf-BprHTK4=UKw8yA@mail.gmail.com> <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
In-Reply-To: <558d0f28-01fb-4447-891c-2ffbf869c077@app.fastmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 19 Feb 2026 09:34:31 -0800
X-Gm-Features: AaiRm522PbtXXP376kUUKctZtEGG7xWnV2UAINAeVODac9_j4h5cpV1OS3ViHZU
Message-ID: <CALCETrWynypSD7vEjJNLcym3JhBw4k0ovDiR_3YuOHh92TnM=A@mail.gmail.com>
Subject: Re: [PATCH v15 00/28] x86: Secure Launch support for Intel TXT
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Simo Sorce <simo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	"Daniel P. Smith" <dpsmith@apertussolutions.com>, Ross Philipson <ross.philipson@oracle.com>, 
	linux-kernel@vger.kernel.org, x86@kernel.org, linux-integrity@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-crypto@vger.kernel.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, iommu@lists.linux.dev, 
	dave.hansen@linux.intel.com, Thomas Gleixner <tglx@linutronix.de>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, peterhuewe@gmx.de, 
	Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca, nivedita@alum.mit.edu, 
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net, corbet@lwn.net, 
	ebiederm@xmission.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, 
	kanth.ghatraju@oracle.com, andrew.cooper3@citrix.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 11:55=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> w=
rote:
>
> On Wed, 18 Feb 2026, at 22:54, Andy Lutomirski wrote:
> > On Wed, Feb 18, 2026 at 1:04=E2=80=AFPM Simo Sorce <simo@redhat.com> wr=
ote:
> >>
> >> On Wed, 2026-02-18 at 12:34 -0800, Andy Lutomirski wrote:
> >> > On Wed, Feb 18, 2026 at 12:29=E2=80=AFPM H. Peter Anvin <hpa@zytor.c=
om> wrote:
> >> > >
> >> > > On February 18, 2026 12:03:27 PM PST, Andy Lutomirski <luto@amacap=
ital.net> wrote:
> >> > > > On Thu, Feb 12, 2026 at 12:40=E2=80=AFPM Ard Biesheuvel <ardb@ke=
rnel.org> wrote:
> >> > > > >
> >> > > > > On Thu, 12 Feb 2026, at 20:49, Daniel P. Smith wrote:
> >> > > > > > On 2/9/26 09:04, Ard Biesheuvel wrote:
> >> > > > > ...
> >> > > > > But would it be better to disable the runtime services by defa=
ult when doing a secure launch? PREEMPT_RT already does the same.
> >> > > >
> >> > > > So I have a possible way to disable EFI runtime service without =
losing
> >> > > > the ability to write EFI vars.  We come up with a simple file fo=
rmat
> >> > > > to store deferred EFI var updates and we come up with a place to=
 put
> >> > > > it so that we find it early-ish in boot the next time around.  (=
This
> >> > > > could be done via integration with systemd-boot or shim some oth=
er
> >> > > > boot loader or it could actually be part of the kernel.)  And th=
en,
> >> > > > instead of writing variables directly, we write them to the defe=
rred
> >> > > > list and then update them on reboot (before TXT launch, etc).  [=
0]
> >> > > > This would be a distincly nontrivial project and would not work =
for
> >> > > > all configurations.
> >> > > >
> >> > > > As a maybe less painful option, we could disable EFI runtime ser=
vices
> >> > > > but have a root-writable thing in sysfs that (a) turns them back=
 on
> >> > > > but (b) first extends a PCR to say that they're turned back on.
> >> > > >
> >> > > > (Or someone could try running runtime services at CPL3...)
> >> > > >
> >> > > > [0] I have thought for years that Intel and AMD should do this o=
n
> >> > > > their end, too.  Keep the sensitive part of SMI flash entirely l=
ocked
> >> > > > after boot and, instead of using magic SMM stuff to validate tha=
t
> >> > > > write attempts have the appropriate permissions and signatures, =
queue
> >> > > > them up as deferred upates and validate the signatures on the ne=
xt
> >> > > > boot before locking flash.
> >> > > >
> >> > >
> >> > > *If* a physical EFI partition exists there is a lot to be said for=
 this approach.
> >> > >
> >> > > The only issue with this that I can see is for things like network=
 or CD/DVD booting where there isn't necessarily any EFI boot partition, it=
 might not be writable, or it might not be persistent (e.g. http booting ty=
pically uses a ramdisk, like the old Linux initrd.)
> >> >
> >> > Hmm, I guess my approach is a 100% complete nonstarter for installin=
g
> >> > Linux from a CD, and it's really not awesome for installing Linux fr=
om
> >> > a USB stick.
> >>
> >> Doing any of this on a removable device feels generally like a trap.
> >> You get your USB disk in, try to boot, and it saves vars, but reboot
> >> fails for whatever reason, you plug it in another machine ... and it
> >> tries to "continue" from there? The amount of validation needed and
> >> testing for failure modes across reboots sounds really painful.
> >
> > I kind of stand by my other previous suggestion, though:
> >
> > As a maybe less painful option, we could disable EFI runtime services
> > but have a root-writable thing in sysfs that (a) turns them back on
> > but (b) first extends a PCR to say that they're turned back on.
> >
>
> After setting the EFI boot path to GRUB (or systemd-boot or whatever) at =
installation time, what other meaningful interactions do we expect with the=
 EFI runtime services?
>
> And given that the secure launch is orchestrated by the bootloader , with=
 which the kernel has a backchannel via its configuration file, it should b=
e rather straight-forward to implement the staging of variable updates ther=
e if we really need it.
>
> Doing any of this at the EFI/spec level might lead to a situation where t=
he OS now has to guess which of the provided APIs to manipulate variables i=
s the least broken.
>
> Of course, for readinf variables, dumping the RT variables into a memory =
buffer at boot time and exposing it via a EFI config table would be rather =
straight-forward, but it is also something I feel should be the job of the =
boot component that takes part in the decision to shield the runtime servic=
es from the OS.

So there's sort of a usability issue here.  On the one hand, this can
all be orchestrated to work.  We build a kernel, and the kernel
supports secure launch.  Someone makes an installer image, and that
image is configured to skip secure launch, then install to disk, then
program EFI vars, then reboot.  And the installed image is configured
to do the secure launch, and EFI variable writes are turned off.

On the other hand, this all sucks.  I'm getting sick of having the
kernel tell me that I am not permitted to do things.  I'm sick of
writing software that deals with unnecessary restrictions.  If I were
writing an OS with a USB stick-based installer, I might want to be
able to boot the thing and decide later whether I'm installing an OS
to disk.  (In fact, many USB installers work this way.)  But, in the
model where EFI variable writes are hard-disabled on a secure launch,
the decision to do the secure launch happens before the decision to
install an OS, and we all lose.

So I'm proposing that EFI variable writes be treated a bit like kexec
[0] -- root (which is already part of the TCB for any practical
purpose) is going to decide, like a grown up, to execute some code
that it doesn't fully trust -- in this case, the EFI variable writes.
And root will coordinate, correctly, with whomever it's busy using the
TPM to coordinate with, and tell it that it's going to do something
that will change its trustworthiness.  So it works like this:

1. Secure launch the environment on the stick.  (At this stage,
neither the boot loader nor the kernel has the faintest clue whether
anyone needs that secure launch, but this doesn't matter.)

2. The owner of the machine clicks "install".

3. The installer makes some partitions and writes some files.

(Up until now, the security posture of the running environment has not chan=
ged.)

4. The installer decides that it's now time to do untrustworthy
things, namely writing EFI vars.  So it unmounts anything it mounted
using TPM-sealed keys (or not -- this is between the distro and
whoever trusts the distro), and it does:

# echo 1 >/sys/.../extend_pcr_and_unlock_efi

which *first* extends a PCR because we are about to change our
security posture and *second* sets whatever flag permits use of EFI
runtime services.

5. The installer writes to EFI variables.  And the installer can no
longer generate attestations to its previous security posture, which
is the correct behavior.  And maybe the user can no longer unlock
their home directory or whatever until they reboot.  Which is not
really a big deal.

(This is *dynamic* root of trust.  In theory the system could do a
DRTM re-launch and recover its security posture, but I don't think
this is implemented.)


One thing I like about this is that it involves very little code.

[0] Do we actually handle kexec intelligently?  I have no idea.  I'm
still getting used to the time that gdb fails half the time because
someone has a strange concept of security.
