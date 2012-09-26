From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: 3.6-rc7 boot crash + bisection
Date: Wed, 26 Sep 2012 10:13:58 -0600
Message-ID: <1348676038.28860.190.camel@bling.home>
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
Cc: Florian Dazinger <florian-Q0TRQrZM+Zzk1uMJSBkQmQ@public.gmane.org>, iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2012-09-26 at 17:04 +0200, Roedel, Joerg wrote:
> On Wed, Sep 26, 2012 at 08:52:01AM -0600, Alex Williamson wrote:
> > Assuming this works, it may be ok as a 3.7 fix, but if there was
> > actually more than one device behind the alias we'd expose them as
> > separate iommu groups.  I don't think that's what we want.  Maybe it
> > should at least get a pr_warn.  Thanks,
> 
> True, we need something more generic as the real fix. When Florian
> reports success I'll try to get this still into 3.6, otherwise to
> -stable.

Yes, 3.6 is what I meant to type.  Thanks,

Alex
