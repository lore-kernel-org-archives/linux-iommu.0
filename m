From: "Kinney, Steven" <Steven.Kinney-5C7GfCeVMHo@public.gmane.org>
Subject: RE: Re-send the AMD IOMMUv2 performance counter patched and PCI
	quirk. Sorry for the noise.
Date: Mon, 26 Nov 2012 14:54:56 +0000
Message-ID: <57D41218901B4442B4AFF404D215911636355B@sausexdag02.amd.com>
References: <20121116232018.GA24141@skinney-Trinity>
	<20121117211010.GC2375@tweety>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20121117211010.GC2375@tweety>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andreas Herrmann <herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org>
Cc: "kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org" <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org" <sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org>, "mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org" <hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org>, "bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org" <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "jkosina-AlSwsSmVLrQ@public.gmane.org" <jkosina-AlSwsSmVLrQ@public.gmane.org>, "tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org" <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" <myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Andreas,

                            This is your quirk, from AMD, and if you need to sign the patch please let me know how to facilitate this.  I will add Joerg using his Email.

Thanks,

Steve

-----Original Message-----
From: Andreas Herrmann [mailto:herrmann.der.user-gM/Ye1E23mwN+BqQ9rBEUg@public.gmane.org] 
Sent: Saturday, November 17, 2012 3:10 PM
To: Kinney, Steven
Cc: tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org; mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org; x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org; Roedel, Joerg; bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org; sebastian-E0PNVn5OA6ohrxcnuTQ+TQ@public.gmane.org; myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org; hdoyu-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org; swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org; jkosina-AlSwsSmVLrQ@public.gmane.org; kgene.kim-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Subject: Re: Re-send the AMD IOMMUv2 performance counter patched and PCI quirk. Sorry for the noise.

Hi Steven,

Hmm, the quirk looks quite familiar to me.

IMHO you should (re-?)read Documentation/SubmittingPatches.
(esp. no attachements, and btw one patch per mail)

Do you mind adding Joerg with his current (non-AMD) mail address on CC? Otherwise it's impossible to get any comment from him.


Andreas
