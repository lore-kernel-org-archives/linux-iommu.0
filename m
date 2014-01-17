From: "Sumner, William" <bill.sumner-VXdhtT5mjnY@public.gmane.org>
Subject: RE: [Q] Why does kexec use device_shutdown rather than ubind them
Date: Fri, 17 Jan 2014 15:57:34 +0000
Message-ID: <875D89B79D1D86448A583A7302C022A055ACA571@G4W3299.americas.hpqcorp.net>
References: <1389929988.7406.18.camel@pasglop> <871u07fbvl.fsf@xmission.com>
	<1389938353.7406.22.camel@pasglop> <20140117141327.GC24394@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140117141327.GC24394-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
To: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Benjamin Herrenschmidt <benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org>
Cc: Matthew Garrett <matthew.garrett-05XSO3Yj/JvQT0dZR+AlfA@public.gmane.org>, "kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Eric W. Biederman" <ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linus Torvalds <torvalds-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Vivek, Ben, Eric,

Please take a look at a proposed patch to intel-iommu: "[PATCHv3 0/6] Crashdump Accepting Active IOMMU"

This is specifically for kdump; however, would some small variation of this technique be applicable to kexec ?

Thanks,
Bill

-----Original Message-----
From: kexec [mailto:kexec-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org] On Behalf Of Vivek Goyal
Sent: Friday, January 17, 2014 8:13 AM
To: Benjamin Herrenschmidt
Cc: Matthew Garrett; kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; Eric W. Biederman; Andrew Morton; Linus Torvalds
Subject: Re: [Q] Why does kexec use device_shutdown rather than ubind them

On Fri, Jan 17, 2014 at 04:59:13PM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2014-01-16 at 20:52 -0800, Eric W. Biederman wrote:
> > 
> > I think we have largely survied until now because kdump is so popular
> > and kdump winds up having to reinitialize devices from any random
> > state.
> 
> kdump also doesn't care too much if the device is still DMA'ing to the
> old kernel memory :-)

In principle kdump does not care about ongoing DMAs but in practice it
is giving us some headaches with IOMMU. Various kind of issues crop up
during IOMMU intialization in second kernel while DMA is ongoing and
unfortunately no good solution has made into upstream yet.

Well, ongoing DMA and IOMMU seems to be orthogonal to using ->remove()
in kexec. So I will stop here. :-)

Thanks
Vivek

_______________________________________________
kexec mailing list
kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
http://lists.infradead.org/mailman/listinfo/kexec
