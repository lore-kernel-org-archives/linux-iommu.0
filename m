From: Waiman Long <longman@redhat.com>
Subject: Re: [RFC PATCH v9 03/13] mm: Add support for eXclusive Page Frame
 Ownership (XPFO)
Date: Wed, 1 May 2019 10:49:44 -0400
Message-ID: <35c4635e-8214-7dde-b4ec-4cb266b2ea10@redhat.com>
References: <cover.1554248001.git.khalid.aziz@oracle.com>
 <f1ac3700970365fb979533294774af0b0dd84b3b.1554248002.git.khalid.aziz@oracle.com>
 <20190417161042.GA43453@gmail.com>
 <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e16c1d73-d361-d9c7-5b8e-c495318c2509@oracle.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Khalid Aziz <khalid.aziz@oracle.com>, Ingo Molnar <mingo@kernel.org>
Cc: juergh@gmail.com, tycho@tycho.ws, jsteckli@amazon.de, keescook@google.com, konrad.wilk@oracle.com, Juerg Haefliger <juerg.haefliger@canonical.com>, deepa.srinivasan@oracle.com, chris.hyser@oracle.com, tyhicks@canonical.com, dwmw@amazon.co.uk, andrew.cooper3@citrix.com, jcm@redhat.com, boris.ostrovsky@oracle.com, iommu@lists.linux-foundation.org, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-security-module@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Dave
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 03, 2019 at 11:34:04AM -0600, Khalid Aziz wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt
b/Documentation/admin-guide/kernel-parameters.txt

> index 858b6c0b9a15..9b36da94760e 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2997,6 +2997,12 @@
>
>      nox2apic    [X86-64,APIC] Do not enable x2APIC mode.
>
> +    noxpfo        [XPFO] Disable eXclusive Page Frame Ownership (XPFO)
> +            when CONFIG_XPFO is on. Physical pages mapped into
> +            user applications will also be mapped in the
> +            kernel's address space as if CONFIG_XPFO was not
> +            enabled.
> +
>      cpu0_hotplug    [X86] Turn on CPU0 hotplug feature when
>              CONFIG_BO OTPARAM_HOTPLUG_CPU0 is off.
>              Some features depend on CPU0. Known dependencies are:

Given the big performance impact that XPFO can have. It should be off by
default when configured. Instead, the xpfo option should be used to
enable it.

Cheers,
Longman
