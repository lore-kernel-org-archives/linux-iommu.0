From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Back from my parental leave
Date: Wed, 17 Jan 2018 20:20:11 +0100
Message-ID: <20180117192011.GU28161@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi,

as some of you already noticed I am back from my leave and am now taking
back the responsibility for the iommu code in the kernel. Actually I am
already back since January 2nd, but I got immediatly thrown into the
Meltdown mitigation work. So I couldn't catch up with IOMMU things as
fast as I wished.

A big Thanks goes to Alex Williamson, who kept things moving during my
absence so that all necessary fixes got upstream and things are prepared
for the next merge window. Thanks a lot, Alex, I owe you at least a
couple of beers :-)

So what is the current status? Today I went through the remaining
patches in my inbox and merged all patches ready for v4.16. If I missed
your patch(es) and you think they should be in v4.16, please ping me and
I will have a look again. Besides that the tree is ready for the
upcoming merge window.

For anything you want me to look at/merge after the next merge window,
please send the patches again. I will not look back at all the patches
that were sent to me during my leave. From my POV my inbox is empty, so
feel free to fill it again after the merge window :-)


Regards,

	Joerg
