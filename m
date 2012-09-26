From: Florian Dazinger <florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org>
Subject: Re: 3.6-rc7 boot crash + bisection
Date: Wed, 26 Sep 2012 19:47:22 +0200
Message-ID: <20120926194722.3d95847e@brain.lan>
References: <20120924210348.5f50677b@brain.lan>
	<1348597970.28860.114.camel@bling.home>
	<20120925205420.0a07dea2@brain.lan>
	<1348602226.28860.132.camel@bling.home>
	<20120926010154.49cc2588@brain.lan>
	<20120926144345.GC10549@amd.com>
	<1348671121.28860.186.camel@bling.home>
	<20120926150407.GD10549@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120926150407.GD10549-5C7GfCeVMHo@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Roedel, Joerg" <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Am Wed, 26 Sep 2012 17:04:07 +0200
schrieb "Roedel, Joerg" <Joerg.Roedel-5C7GfCeVMHo@public.gmane.org>:

> On Wed, Sep 26, 2012 at 08:52:01AM -0600, Alex Williamson wrote:
> > Assuming this works, it may be ok as a 3.7 fix, but if there was
> > actually more than one device behind the alias we'd expose them as
> > separate iommu groups.  I don't think that's what we want.  Maybe it
> > should at least get a pr_warn.  Thanks,
> 
> True, we need something more generic as the real fix. When Florian
> reports success I'll try to get this still into 3.6, otherwise to
> -stable.
> 
> 
> 	Joerg
> 

 ... updating to the newest BIOS revision does not make any difference, rc7 is crashing, rc7+patch is not, I definitely need this patch.
If there is more you want me to test, pls tell.

Florian
