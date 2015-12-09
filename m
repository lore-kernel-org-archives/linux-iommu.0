From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: Regression since 4.1
Date: Wed, 09 Dec 2015 12:07:48 -0700
Message-ID: <1449688068.15753.461.camel@redhat.com>
References: <5418503.92eb9JWhCR@t400>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <5418503.92eb9JWhCR@t400>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Tobias Geiger <tobias.geiger-9woOUGhjKTphl2p70BpVqQ@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, 2015-12-09 at 18:01 +0100, Tobias Geiger wrote:
> Hello!
> 
> in short:
> No Kernel since 4.1 boots on my machine.
> 
> I can make newer kernels boot, but ONLY when i remove "iommu=on 
> intel_iommu=on" from the cmdline.
> If i leave it in, as with all the kernels before and including 4.1, newer 
> kernels dont boot, and in a really not very informative way:
> They dont even print a single message to the console, i only see the grub-
> messages (like "loading kernel" and "loading initial ramdisk") - after these 
> messages NO more output of any kind - also no SysRQ keys working - nothing.
> 
> Because of this complete lack of information, i guess its hard to debug for 
> you the cause of this.
> Perhaps i can help - but how?
> 
> i'm writing from a pure IOMMU-User perspective - i can compile kernels, but 
> never git-bisected, so maybe a hint to a tutorial for that would be great!


Try simply removing the "quiet" and "splash" or "rhgb" options if there
are any from the kernel command line in grub first.  You can temporarily
just editing the commandline manually as you boot.  If you don't have a
serial console available, at least have a camera handy to take a picture
of the screen.  You can also add "ignore_loglevel" to the kernel
commandline to get more logging.  Thanks,

Alex
