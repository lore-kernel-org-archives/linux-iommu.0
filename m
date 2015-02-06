From: Hann Huang <gic4107-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: question about AMD IOMMU IO_PAGE_FAULT event and PRI
Date: Fri, 6 Feb 2015 11:45:55 +0800
Message-ID: <CALu9Y57totEk4o+r7EKOK0kZjPNmnBJBQvhLkGmtyrv1EgCNvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2455574371743049233=="
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
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
List-Id: iommu@lists.linux-foundation.org

--===============2455574371743049233==
Content-Type: multipart/alternative; boundary=001a1140cd1e0626e7050e6342c7

--001a1140cd1e0626e7050e6342c7
Content-Type: text/plain; charset=UTF-8

Hi all,

I did some experiment which needs two-stage address translation
(GVA->GPA->SPA).
After setting the mode bit in DTE to 100b, I got lots of IO_PAGE_FAULT
event but no any PPR request.
While turn off the GPA-to-SPA translation, PPR request comes and no
IO_PAGE_FAULT event.

My question is :
In what situation IO_PAGE_FAULT event generate, and how about PRI request?
Can IO_PAGE_FAULT event be fixed? (such as handle the page fault and send
COMPLETE_PPR_REQUEST?)

Thanks for your advice.

Best Regards,
Hann Huang

--001a1140cd1e0626e7050e6342c7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div><div>Hi all, <br><br></=
div>I did some experiment which needs two-stage address translation (GVA-&g=
t;GPA-&gt;SPA).<br></div>After setting the mode bit in DTE to 100b, I got l=
ots of IO_PAGE_FAULT event but no any PPR request. <br></div>While turn off=
 the GPA-to-SPA translation, PPR request comes and no IO_PAGE_FAULT event.<=
br><br></div>My question is : <br>In what situation IO_PAGE_FAULT event gen=
erate, and how about PRI request?<br></div>Can IO_PAGE_FAULT event be fixed=
? (such as handle the page fault and send COMPLETE_PPR_REQUEST?)<br><br></d=
iv>Thanks for your advice.<br><br></div>Best Regards,<br></div>Hann Huang</=
div>

--001a1140cd1e0626e7050e6342c7--

--===============2455574371743049233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2455574371743049233==--
