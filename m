From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: Marvell 88NV9143 in mini-PCIe not working with intel_iommu=on
Date: Tue, 26 Mar 2013 16:14:37 +0100
Message-ID: <20130326151436.GE2727@8bytes.org>
References: <874ngpj3d9.fsf@meteor.durcheinandertal.bofh>
	<CAJtEV7Zyq3+YPu9Vvcxcm8nw41-ENjLuRHUzyFFzXQn-wiSf1w@mail.gmail.com>
	<87zjyfy325.fsf@meteor.durcheinandertal.bofh>
	<CAJtEV7aL0TeSYB-+1bTgq=8Rbt2wijLfQF7jrHHXTeXeR811DQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJtEV7aL0TeSYB-+1bTgq=8Rbt2wijLfQF7jrHHXTeXeR811DQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: jyli-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Gaudenz Steinlin <gaudenz-Pp/UeI/YXckUgOneFgkt3A@public.gmane.org>, Shun Fu <fushun-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Fri, Mar 08, 2013 at 10:53:16AM +0800, Andrew Cooks wrote:
> I'm hoping one of the veteran developers would give some guidance for
> the best approach to enable more devices in future.

In cases like this where a device just uses the request-id of another
device you can make use of the existing quirk-code in
drivers/pci/quirks.c. Look at the function pci_get_dma_source() and add
your device there. This should also make it work with VT-d and AMD-Vi.


	Joerg
